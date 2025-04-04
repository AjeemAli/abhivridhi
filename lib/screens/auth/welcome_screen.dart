import 'dart:async';
import 'package:abhivridhiapp/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_images.dart'; // Update with correct path

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    String? token = await getAuthToken();

    // Navigate based on authentication token
    Future.delayed(const Duration(seconds: 5), () {
      if (token != null && token.isNotEmpty) {
        Get.offNamed('/dashboard');
        print('Token value $token');
      } else {
        print('Token value null!');
        Get.offNamed('/onboarding');
      }
    });
  }

  Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Image.asset(
          AppImages.logo,
          height: 120,
        ),
      ),
    );
  }
}
