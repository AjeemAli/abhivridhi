import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';


class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Image
              Image.asset(
                'assets/images/pay_succes.png', // Change this to your actual image path
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),

              // Heading
              const Text(
                "Payment Successful!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),


              // Subheading
              const Text(
                """Your Payment was successful done. Our rider will deliver your order at home.""",
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // First Button: Go to Home
              CustomButton(
                onPressed:() {
                  Get.offAllNamed('/payment-success');
                },

                width: double.infinity,
                borderRadius: 30,
                height: 48,
                text: 'Track Order Status',
                textColor: AppColors.text,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                isDisabled: false,
                hasShadow: false,
                isOutlined: false,
                color: AppColors.btnColor,
                //borderColor: AppColors.primary,
              ),
              const SizedBox(height: 10),

              // Second Button: View Order
              CustomButton(
                onPressed:() {
                  Get.offAllNamed('/dashboard');
                },
                width: double.infinity,
                borderRadius: 30,
                height: 48,
                text: 'Back to Home',
                textColor: AppColors.textDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                isDisabled: false,
                hasShadow: false,
                isOutlined: false,
                color: AppColors.secondary,
                //borderColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
