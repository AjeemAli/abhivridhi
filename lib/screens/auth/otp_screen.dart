import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Verification with Code",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Enter the code sent to ",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                children: [
                  TextSpan(
                    text: "(+91) 0123456789",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.error),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Pinput(
              length: 4,
              controller: _otpController,
              keyboardType: TextInputType.number,
              pinAnimationType: PinAnimationType.fade,

              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.warning),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn’t receive the code? "),
                GestureDetector(
                  onTap: () {
                    // Resend Code Functionality
                  },
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: 100,),
            CustomButton(
              onPressed: () {
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
