import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_images.dart';
import '../../widgets/custom_button.dart';

class LoginOptionsScreen extends StatelessWidget {
  const LoginOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Spacer(),
            Center(child: Image.asset(AppImages.logo, height: 180)),
            Spacer(),
            CustomButton(
              onPressed: () { Get.toNamed('/login-with-phone');} ,
              width: double.infinity,
              borderRadius: 30,
              height: 48,
              text: 'Login',
              isDisabled: false,
              hasShadow: false,
              isOutlined: false,
              color: AppColors.btnColor,
            ),
            CustomButton(
              onPressed: () { Get.toNamed('/phone-signup');} ,
              width: double.infinity,
              borderRadius: 30,
              height: 48,
              text: 'New to Filllo? Sign Up!',
              isDisabled: false,
              hasShadow: false,
              isOutlined: false,
              color: AppColors.textDark,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
