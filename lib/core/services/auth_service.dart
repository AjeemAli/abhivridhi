import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_services.dart';



class AuthController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());

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

      if (response != null && response['token'] != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String token = response['token'];
        final Map<String, dynamic> user = response['user'];

        // Save token
        await prefs.setString('auth_token', token);

        // Save additional user data if needed
        await prefs.setInt('user_id', user['id']);
        await prefs.setString('user_name', user['name'] ?? '');
        await prefs.setString('user_mobile', user['mobile'] ?? '');
        await prefs.setString('user_type', user['user_type'] ?? '');

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

      if (response != null) {
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
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_mobile');
    await prefs.remove('user_type');

    Get.offAllNamed('/login-with-phone');
    Get.snackbar('Success', 'Logged out successfully', snackPosition: SnackPosition.BOTTOM);
  }
}

// Utility function to retrieve the auth token
Future<String?> getAuthToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  print("Token retrieved from SharedPreferences: $token");
  return token;
}





