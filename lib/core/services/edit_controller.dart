import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/profile_model.dart';
import 'api_services.dart';

class EditController extends GetxController {
  final Rx<ProfileModel> profile = ProfileModel().obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final ApiService _apiService = ApiService();

  Future<void> updateProfile(String name, String city) async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await _apiService.postRequest(
        'app/update_profile',
        data: {'name': name, 'city': city},
        requiresAuth: true,
      );

      if (response != null && response['user'] != null) {
        profile.value.user = User.fromJson(response['user']);
        profile.refresh(); // Force UI update
        Get.snackbar('Success', 'Profile updated successfully');
        Get.offAllNamed('/dashboard'); // Go back after successful update
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }
}
