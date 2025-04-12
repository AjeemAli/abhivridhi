import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    final position = await Geolocator.getCurrentPosition();
    await _saveLocationToPrefs(position);
    return position;
  }

  static Future<void> _saveLocationToPrefs(Position position) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('lat', position.latitude);
    await prefs.setDouble('lng', position.longitude);
    await prefs.setString('last_location_update', DateTime.now().toString());
  }

  static Future<Map<String, dynamic>?> getLastLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble('lat');
    final lng = prefs.getDouble('lng');
    final lastUpdate = prefs.getString('last_location_update');

    if (lat == null || lng == null) return null;

    return {
      'latitude': lat,
      'longitude': lng,
      'last_update': lastUpdate,
    };
  }

  static Future<String?> getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        final address = "${place.locality}, ${place.administrativeArea}";
        await _saveAddressToPrefs(address);
        return address;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<void> _saveAddressToPrefs(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_address', address);
  }

  static Future<String?> getLastAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_address');
  }
}
