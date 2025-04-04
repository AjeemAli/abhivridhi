import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/auth_service.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class LoginWithPassword extends StatefulWidget {
  const LoginWithPassword({super.key});

  @override
  State<LoginWithPassword> createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  final AuthController controller = Get.put(AuthController());
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordValid = false;
  bool isPasswordVisible = false;

  void validatePassword(String value) {
    setState(() {
      isPasswordValid = value.length >= 8;
    });
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
              'Log in with Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Please enter your password to continue',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Password Input Field
            CustomTextField(
              label: 'Password',
              hint: 'Enter your password',
              obscureText: !isPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              enabled: true,
              maxLines: 1,
              controller: passwordController,
              onChanged: validatePassword,
              suffixIcon: isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              onSuffixTap: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 10),

            const Text(
              'Must be at least 8 characters.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 100),

            // Continue Button with Loader Integration
            Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              onPressed: isPasswordValid
                  ? () {
                debugPrint("Login Auth");
                controller.password.value =
                    passwordController.text.trim();
                controller.login();
              }
                  : null,
              width: double.infinity,
              borderRadius: 30,
              height: 48,
              text: 'Login',
              textColor: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              isDisabled: !isPasswordValid,
              hasShadow: false,
              isOutlined: false,
              color: isPasswordValid
                  ? AppColors.primary
                  : Colors.grey,
            )),
          ],
        ),
      ),
    );
  }
}
