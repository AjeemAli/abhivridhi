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
  var fromSuggestions = [].obs;
  var toSuggestions = [].obs;

  RxMap<String, dynamic> selectedFromLocation = <String, dynamic>{}.obs;
  RxMap<String, dynamic> selectedToLocation = <String, dynamic>{}.obs;

  final String googleApiKey = "AIzaSyDuMG2WaY4Vwi0iM3XqPdUrNAcvjHtR8wE";

  // Clear all location data
  void clearAll() {
    fromSuggestions.clear();
    toSuggestions.clear();
    selectedFromLocation.clear();
    selectedToLocation.clear();
  }

  // Fetch suggestions for either from/to location
  Future<void> fetchSuggestions(String input, bool isFrom) async {
    if (input.isEmpty) {
      isFrom ? fromSuggestions.clear() : toSuggestions.clear();
      return;
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey&components=country:in'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (isFrom) {
          fromSuggestions.value = data['predictions'] ?? [];
        } else {
          toSuggestions.value = data['predictions'] ?? [];
        }
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
      isFrom ? fromSuggestions.clear() : toSuggestions.clear();
    }
  }

  // Get detailed place information
  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,formatted_address,geometry,address_components&key=$googleApiKey'
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
        'street': _extractComponent(components, 'route'),
        'city': _extractComponent(components, 'locality') ??
            _extractComponent(components, 'administrative_area_level_2'),
        'district': _extractComponent(components, 'administrative_area_level_2'),
        'state': _extractComponent(components, 'administrative_area_level_1'),
        'pincode': _extractComponent(components, 'postal_code'),
      };
    }
    return {};
  }

  String? _extractComponent(List components, String type) {
    try {
      return (components.firstWhere(
              (c) => c['types'].contains(type),
          orElse: () => {'long_name': null}
      ))['long_name'];
    } catch (e) {
      return null;
    }
  }
}

