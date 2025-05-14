import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/services/edit_controller.dart';
import '../../core/services/profile_controller.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';



class EditProfileScreen extends StatelessWidget {
  final ProfileController profileController =  Get.put(ProfileController());
  final EditController editController =  Get.put(EditController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = profileController.profile.value.user;

    if (user != null) {
      nameController.text = user.name ?? '';
      // cityController.text = user.city ?? ''; // Assuming `city` is in the model
      // emailController.text = user.email ?? '';
      phoneController.text = user.mobile ?? '';
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Editable Name Field
              CustomTextField(
                controller: nameController,
                label: 'Name',
                hint: 'Enter your name',
                prefixIcon: Icons.person,
                textInputAction: TextInputAction.next,
                obscureText: false,
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabled: true,
                onSubmitted: (value) {},
              ),
              const SizedBox(height: 16),

              // Editable City Field
              CustomTextField(
                controller: cityController,
                label: 'City',
                hint: 'Enter your city',
                prefixIcon: Icons.location_city,
                textInputAction: TextInputAction.next,
                obscureText: false,
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabled: true,
                onSubmitted: (value) {},
              ),
              const SizedBox(height: 16),

              // Read-Only Email Field
              CustomTextField(
                controller: emailController,
                label: 'Email (Not Editable)',
                hint: '',
                prefixIcon: Icons.email,
                textInputAction: TextInputAction.none,
                obscureText: false,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                enabled: false,
                onSubmitted: (_) {},
              ),
              const SizedBox(height: 16),

              // Read-Only Phone Field
              CustomTextField(
                controller: phoneController,
                label: 'Phone (Not Editable)',
                hint: '',
                prefixIcon: Icons.phone,
                textInputAction: TextInputAction.none,
                obscureText: false,
                maxLines: 1,
                keyboardType: TextInputType.phone,
                enabled: false,
                onSubmitted: (_) {},
              ),
              const SizedBox(height: 30),

              // Update Button
              CustomButton(
                text: "Update Profile",
                width: double.infinity,
                height: 48,
                onPressed: () {
                  editController.updateProfile(
                    nameController.text.trim(),
                    cityController.text.trim(),
                  );
                },
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textColor: Colors.white,
                borderRadius: 30,
                hasShadow: false,
                isOutlined: false,
                color: AppColors.primary,
                isDisabled: false,
              ),
            ],
          ),
        );
      }),
    );
  }
}


