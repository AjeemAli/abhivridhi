import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'api_services.dart';


class ChangePasswordController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();

  var showOtpFields = false.obs;
  var isLoading = false.obs;

  Future<void> requestOtp() async {
    final mobile = phoneController.text.trim();

    if (mobile.isEmpty) {
      Get.snackbar('Error', 'Please enter mobile number', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiService.postRequest('app/forgot-password', data: {
        'mobile': mobile,
      });

      if (response != null) {
        showOtpFields.value = true;
        Get.snackbar('Success', 'OTP sent successfully', snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to send OTP. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePassword() async {
    final mobile = phoneController.text.trim();
    final otp = otpController.text.trim();
    final newPassword = newPasswordController.text.trim();

    if (mobile.isEmpty || otp.isEmpty || newPassword.isEmpty) {
      Get.snackbar('Error', 'All fields are required', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiService.postRequest('app/reset-password', data: {
        'mobile': mobile,
        'otp': otp,
        'new_password': newPassword,
      });

      if (response != null) {
        Get.snackbar('Success', 'Password updated successfully', snackPosition: SnackPosition.BOTTOM);
        // Optionally navigate or clear fields
      } else {
        throw Exception('Failed to update password. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}

