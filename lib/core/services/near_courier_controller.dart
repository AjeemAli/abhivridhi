import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../models/near_courier_model.dart';
import 'api_services.dart';
import 'location_service.dart';


import 'dart:async'; // For Completer
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class NearbyPlacesController extends GetxController {
  final Rx<NearPlaceCourierModel> nearbyPlaces = NearPlaceCourierModel().obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxDouble currentLatitude = 0.0.obs;
  final RxDouble currentLongitude = 0.0.obs;
  final RxString locationAddress = 'Fetching location...'.obs;
  final ApiService _apiService = ApiService();
  final int defaultRadius = 5; // Default radius set to 5 km

  // Adding map controller variable
  Completer<GoogleMapController> mapController = Completer();

  @override
  void onInit() {
    super.onInit();
    _initLocationAndFetchPlaces();
  }

  // Initialize location and fetch places based on the location
  Future<void> _initLocationAndFetchPlaces() async {
    await _getCurrentLocation();
    if (currentLatitude.value != 0.0 && currentLongitude.value != 0.0) {
      await fetchNearbyPlaces(currentLatitude.value, currentLongitude.value);
    }
  }

  // Get the current location using a location service
  Future<void> _getCurrentLocation() async {
    try {
      isLoading(true);

      // Check if we have recent cached location
      final cachedLocation = await LocationService.getLastLocation();
      final isLocationRecent = cachedLocation != null &&
          !DateTime.parse(cachedLocation['last_update'] ?? DateTime(1970))
              .isBefore(DateTime.now().subtract(Duration(hours: 1)));

      if (isLocationRecent) {
        currentLatitude.value = cachedLocation['latitude'];
        currentLongitude.value = cachedLocation['longitude'];
        locationAddress.value = await LocationService.getLastAddress() ?? 'Location available';
        return;
      }

      // Fetch fresh location
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        currentLatitude.value = position.latitude;
        currentLongitude.value = position.longitude;
        locationAddress.value = await LocationService.getAddressFromPosition(position) ?? 'Location available';
      } else {
        errorMessage.value = 'Location permission denied';
      }
    } catch (e) {
      errorMessage.value = 'Error getting location: ${e.toString()}';
    }
  }

  // Fetch nearby places based on the current latitude and longitude
  Future<void> fetchNearbyPlaces(double latitude, double longitude, {double? radius}) async {
    try {
      isLoading(true);
      errorMessage('');  // Clear any previous error messages

      // Use the default radius if the radius is null
      radius ??= defaultRadius.toDouble();

      // Ensure radius is a valid number before passing to the request
      if (radius <= 0) {
        errorMessage.value = 'Radius must be a positive number';
        return;
      }

      final response = await _apiService.getRequest(
        'app/nearby-places?latitude=$latitude&longitude=$longitude&radius=$radius',
        requiresAuth: true,
      );

      if (response != null && response is Map<String, dynamic>) {
        nearbyPlaces.value = NearPlaceCourierModel.fromJson(response);

        // Update distances in the list based on current location
        if (nearbyPlaces.value.data != null) {
          for (var place in nearbyPlaces.value.data!) {
            if (place.latitude != null && place.longitude != null) {
              place.distance = _calculateDistance(
                latitude,
                longitude,
                double.parse(place.latitude!),
                double.parse(place.longitude!),
              );
            }
          }
        }
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      errorMessage.value = 'Error fetching nearby places: ${e.toString()}';
      debugPrint(errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  // Calculate distance between two geographic locations
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000; // in km
  }

  // Refresh the nearby places data
  Future<void> refreshData() async {
    await _getCurrentLocation();
    if (currentLatitude.value != 0.0 && currentLongitude.value != 0.0) {
      await fetchNearbyPlaces(currentLatitude.value, currentLongitude.value);
    }
  }

  // Clear cached data
  void clearData() {
    nearbyPlaces.value = NearPlaceCourierModel();
    errorMessage('');
  }
}






class LocationService {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle the case when location services are disabled
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case when permission is denied
        return null;
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  static Future<String?> getAddressFromPosition(Position position) async {
    // You can use geocoding to get the address from coordinates
    // For example, use the `geocoding` package here.
    return "Address from coordinates";
  }

  static Future<Map<String, dynamic>?> getLastLocation() async {
    // Retrieve the last known location from cache
    return null;
  }

  static Future<String?> getLastAddress() async {
    // Retrieve the last known address from cache
    return null;
  }
}
