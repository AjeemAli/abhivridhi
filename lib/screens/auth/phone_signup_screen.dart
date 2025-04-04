import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../core/services/auth_service.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';

class PhoneSignupScreen extends StatelessWidget {
  PhoneSignupScreen({super.key});

  final AuthController controller = Get.put(AuthController());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Continue with phone",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter your phone number to proceed.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 50),

            // Phone Number Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Country Code & Flag
                  SizedBox(
                    width: 110,
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        countryCodeController.text = number.dialCode ?? '+91';
                      },
                      selectorConfig: const SelectorConfig(
                        leadingPadding: 0,
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: true,
                      autoValidateMode: AutovalidateMode.disabled,
                      textFieldController: countryCodeController,
                      inputDecoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // Phone Number Input
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter phone number",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Continue Button
            CustomButton(
              onPressed: () {
                if (phoneController.text.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please enter a valid phone number.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                // Save data in controller for later API call
                controller.mobile.value =
                    '${countryCodeController.text}${phoneController.text.trim()}';
                debugPrint("Phone no ${controller.mobile.value}");
                Get.toNamed('/username-setup');
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
