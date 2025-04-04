import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/auth_service.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class UsernameSetupScreen extends StatelessWidget {
  UsernameSetupScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your Username',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Please provide your username to continue',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Username Input
            CustomTextField(
              controller: usernameController,
              label: 'Username',
              hint: 'Enter your username',
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              enabled: true,
              maxLines: 1,
            ),

            const SizedBox(height: 100),

            // Continue Button
            CustomButton(
              onPressed: () {
                if (usernameController.text.trim().isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please enter a valid username.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                // Save username in controller for later API call
                controller.username.value = usernameController.text.trim();
                debugPrint("valid username ${controller.username.value}");
                Get.toNamed('/password-setup');
              },
              width: double.infinity,
              borderRadius: 30,
              height: 48,
              text: 'Continue',
              textColor: AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              isDisabled: false,
              hasShadow: false,
              isOutlined: false,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
