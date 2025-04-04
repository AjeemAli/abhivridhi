import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_services.dart';


class AuthController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());

  // Observables for loading and user data
  var isLoading = false.obs;

  var mobile = ''.obs;
  var username = ''.obs;
  var password = ''.obs;


  // Login Function
  Future<void> login() async {
    print("Login Auth ${mobile.value} ${password.value}");

    if (mobile.value.trim().isEmpty || password.value.trim().isEmpty) {
      Get.snackbar('Error', 'Please fill in all login fields', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      final response = await _apiService.postRequest('app/login', data: {
        'mobile': mobile.value.trim(),
        'password': password.value.trim(),
      });

      if (response != null && response['user'] != null && response['user']['token'] != null) {
        final String token = response['user']['token'];

        // Store the token in SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        Get.snackbar('Success', 'Login successful', snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed('/dashboard');
      } else {
        throw Exception(response?['message'] ?? 'Invalid login credentials');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }



  // Signup Function
  Future<void> signup() async {
    if (mobile.value.trim().isEmpty || username.value.trim().isEmpty || password.value.trim().isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiService.postRequest('app/signup', data: {
        'name': username.value.trim(),
        'mobile': mobile.value.trim(),
        'password': password.value.trim(),
      });

      if (response != null && response['status'] == true) {
        Get.snackbar('Success', 'Signup successful', snackPosition: SnackPosition.BOTTOM);
        Get.offNamed('/login-with-phone');
      } else {
        throw Exception(response?['message'] ?? 'Signup failed, please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }


  // Logout Function
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    Get.offAllNamed('/login-with-phone');
    Get.snackbar('Success', 'Logged out successfully', snackPosition: SnackPosition.BOTTOM);
  }

}


Future<String?> getAuthToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

