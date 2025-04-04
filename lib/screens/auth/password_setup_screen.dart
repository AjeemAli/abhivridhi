import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/auth_service.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class PasswordSetupScreen extends StatefulWidget {
  const PasswordSetupScreen({super.key});

  @override
  State<PasswordSetupScreen> createState() => _PasswordSetupScreenState();
}

class _PasswordSetupScreenState extends State<PasswordSetupScreen> {
  final AuthController controller = Get.find<AuthController>();
  final TextEditingController passwordController = TextEditingController();

  double strength = 0.0;
  String strengthLabel = 'Weak';

  // Function to check password strength
  void checkPasswordStrength(String value) {
    setState(() {
      final password = value.trim();

      if (password.isEmpty) {
        strength = 0.0;
        strengthLabel = "Weak";
      } else if (password.length < 6) {
        strength = 0.2;
        strengthLabel = "Very Weak";
      } else if (password.length < 8) {
        strength = 0.4;
        strengthLabel = "Weak";
      } else if (RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])').hasMatch(password)) {
        strength = 0.7;
        strengthLabel = "Medium";
      } else if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])').hasMatch(password)) {
        strength = 1.0;
        strengthLabel = "Strong";
      } else {
        strength = 0.5;
        strengthLabel = "Average";
      }
    });
  }

  // Password Validation
  bool isPasswordValid(String password) {
    return password.length >= 8 &&
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])').hasMatch(password);
  }

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
              'Setup Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Please create a secure password including the following criteria below',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Password Input Field
            CustomTextField(
              controller: passwordController,
              label: 'Password',
              hint: 'Enter your password',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              enabled: true,
              maxLines: 1,
              onChanged: checkPasswordStrength,
            ),
            const SizedBox(height: 10),

            const Text(
              'Must be at least 8 Characters with uppercase, lowercase & numbers.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Password Strength Indicator
            Row(
              children: [
                Text(
                  'Password Strength: $strengthLabel',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LinearProgressIndicator(
                    value: strength,
                    backgroundColor: Colors.grey[300],
                    color: strength == 1.0
                        ? Colors.green
                        : strength >= 0.7
                        ? Colors.blue
                        : strength >= 0.5
                        ? Colors.orange
                        : Colors.red,
                    minHeight: 8,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100),

            // Continue Button
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : CustomButton(
              onPressed: isPasswordValid(passwordController.text)
                  ? () {
                controller.password.value = passwordController.text.trim();
                debugPrint("valid password ${controller.password.value}");
                controller.signup();
              } : null,

              width: double.infinity,
              borderRadius: 30,
              height: 48,
              text: 'Set up',
              textColor: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              isDisabled: !isPasswordValid(passwordController.text),
              hasShadow: false,
              isOutlined: false,
              color: isPasswordValid(passwordController.text)
                  ? AppColors.primary
                  : Colors.grey,
            )),
          ],
        ),
      ),
    );
  }
}

