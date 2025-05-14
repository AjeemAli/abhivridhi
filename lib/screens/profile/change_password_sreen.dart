import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/services/change_password_controller.dart';
import '../../widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Change Password'), backgroundColor: Colors.indigo),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile Number',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                CustomTextField(
                  controller: controller.phoneController,
                  label: 'Number',
                  hint: 'Enter your number',
                  prefixIcon: Icons.phone,
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  enabled: !controller.showOtpFields.value,
                  onSubmitted: (value) {},
                ),
                const SizedBox(height: 30),

                if (controller.showOtpFields.value) ...[
                  Text(
                    'OTP',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  CustomTextField(
                    controller: controller.otpController,
                    label: 'OTP',
                    hint: 'Enter OTP',
                    prefixIcon: Icons.lock_outline,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {}, enabled: true,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'New Password',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  CustomTextField(
                    controller: controller.newPasswordController,
                    label: 'New Password',
                    hint: 'Enter new password',
                    prefixIcon: Icons.lock,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    onSubmitted: (value) {}, enabled: true,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: controller.updatePassword,
                    icon: Icon(Icons.check),
                    label: Text('Update Password'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: Size(double.infinity, 48),
                    ),
                  ),
                ] else ...[
                  ElevatedButton.icon(
                    onPressed: controller.requestOtp,
                    icon: Icon(Icons.send),
                    label: Text('Get OTP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: Size(double.infinity, 48),
                    ),
                  ),
                ],
              ],
            );
          }),
        ),
      ),
    );
  }
}

