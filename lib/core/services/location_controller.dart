import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';
import '../utils/locaion_permission_dialog.dart';

class LocationDataController extends GetxController {
  var locationText = "Fetching location...".obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final cachedAddress = await LocationService.getLastAddress();
    if (cachedAddress != null) {
      locationText.value = cachedAddress;
    }
    _checkLocation();
  }

  Future<void> _checkLocation() async {
    final cachedLocation = await LocationService.getLastLocation();
    final isLocationOld = cachedLocation == null ||
        DateTime.tryParse(cachedLocation['last_update'] ?? "")!.isBefore(
          DateTime.now().subtract(const Duration(hours: 1)),
        ) ??
        true;

    if (isLocationOld) {
      await _verifyPermissionAndFetch();
    }
  }

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
