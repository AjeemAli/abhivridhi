import 'dart:convert';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../services/location_service.dart';
import '../utils/locaion_permission_dialog.dart';

class LocationDataController extends GetxController {
  var locationText = "Fetching location...".obs;
  var isLoading = false.obs;

  // Called automatically when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    _initLocation();
  }

  // Load cached location if available, then check for updates
  Future<void> _initLocation() async {
    final cachedAddress = await LocationService.getLastAddress();
    if (cachedAddress != null) {
      locationText.value = cachedAddress;
    }
    _checkLocation();
  }

  // Check if the cached location is older than 1 hour, fetch if outdated
  Future<void> _checkLocation() async {
    final cachedLocation = await LocationService.getLastLocation();
    final isLocationOld = cachedLocation == null ||
        DateTime.tryParse(cachedLocation['last_update'] ?? "")!.isBefore(
          DateTime.now().subtract(const Duration(hours: 1)),
        ) ?? true;

    if (isLocationOld) {
      await _verifyPermissionAndFetch();
    }
  }

  // Ask user for location permission if not granted already
  Future<void> _verifyPermissionAndFetch() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      bool? allow = await Get.dialog<bool>(const LocationPermissionDialog());
      if (allow != true) {
        if (locationText.value == "Fetching location...") {
          locationText.value = "Location not available";
        }
        return;
      }
    }

    await _fetchLocation();
  }

  // Get the current location, convert to address and update UI
  Future<void> _fetchLocation() async {
    isLoading.value = true;

    try {
      Position? position = await LocationService.getCurrentLocation();
      if (position != null) {
        String? address = await LocationService.getAddressFromPosition(position);
        locationText.value = address ?? "Location found";
      } else {
        locationText.value = "Permission denied";
      }
    } catch (e) {
      locationText.value = "Error fetching location";
    } finally {
      isLoading.value = false;
    }
  }
}



class PlaceSearchController extends GetxController {
  var fromSuggestions = [].obs; // Suggestions for "From" location input
  var toSuggestions = [].obs;   // Suggestions for "To" location input

  RxMap<String, dynamic> selectedFromLocation = <String, dynamic>{}.obs;
  RxMap<String, dynamic> selectedToLocation = <String, dynamic>{}.obs;

  final String googleApiKey = "AIzaSyDuMG2WaY4Vwi0iM3XqPdUrNAcvjHtR8wE";

  // Fetch suggestions from Google API for "From" location
  Future<void> fetchFromSuggestions(String input) async {
    await _fetchSuggestions(input, isFrom: true);
  }

  // Fetch suggestions from Google API for "To" location
  Future<void> fetchToSuggestions(String input) async {
    await _fetchSuggestions(input, isFrom: false);
  }

  // Shared method to fetch autocomplete suggestions
  Future<void> _fetchSuggestions(String input, {required bool isFrom}) async {
    if (input.isEmpty) {
      isFrom ? fromSuggestions.clear() : toSuggestions.clear();
      return;
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'];
      if (isFrom) {
        fromSuggestions.value = predictions;
      } else {
        toSuggestions.value = predictions;
      }
    } else {
      isFrom ? fromSuggestions.clear() : toSuggestions.clear();
    }
  }

  // Get full details (address, lat/lng) of a selected place
  Future<Map<String, dynamic>?> getPlaceDetails(String placeId) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
          '?place_id=$placeId'
          '&fields=formatted_address,geometry,address_component'
          '&key=$googleApiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final result = data['result'];
      final components = result['address_components'] as List;

      return {
        'address': result['formatted_address'],
        'lat': result['geometry']['location']['lat'],
        'lng': result['geometry']['location']['lng'],
        'area': _extractCityOrArea(components),
      };
    }

    return null;
  }

  // Set selected place data for "From" location
  Future<void> setFromLocation(String placeId) async {
    final details = await getPlaceDetails(placeId);
    if (details != null) {
      selectedFromLocation.value = details;
    }
  }

  // Set selected place data for "To" location
  Future<void> setToLocation(String placeId) async {
    final details = await getPlaceDetails(placeId);
    if (details != null) {
      selectedToLocation.value = details;
    }
  }

  // Extract city or area name from address components
  String _extractCityOrArea(List components) {
    for (var comp in components) {
      if (comp['types'].contains('locality')) {
        return comp['long_name'];
      }
      if (comp['types'].contains('administrative_area_level_2')) {
        return comp['long_name'];
      }
    }
    return components.first['long_name'];
  }
}

