import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Location Permission"),
      content: const Text(
          "This app needs location permission to show your current location. Would you like to enable it?"),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: const Text("Skip"),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text("Allow"),
        ),
      ],
    );
  }
}
