import 'package:abhivridhiapp/screens/profile/widgets/packages_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/profile_controller.dart';
import '../../../core/utils/app_color.dart';
import '../../../models/profile_model.dart';
import '../../../widgets/custom_button.dart';
import 'basic_info_widget.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      ProfileModel profile = controller.profile.value;
      String name = profile.user?.name ?? "No Name Available";
      String mobile = profile.user?.mobile ?? "No Mobile Available";
      String userId = profile.user?.userType ?? "N/A";
      String createdAt = profile.user?.createdAt ?? "N/A";

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              Text(
                "Mobile: $mobile",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onPressed: () async {
                      final Uri smsUri = Uri(
                        scheme: 'sms',
                        path: mobile,
                      );
                      if (await canLaunchUrl(smsUri)) {
                        await launchUrl(smsUri);
                      } else {
                        Get.snackbar("Error", "Unable to open messaging app");
                      }
                    },
                    icon: Icons.chat_outlined,
                    width: MediaQuery.of(context).size.width * 0.45,
                    borderRadius: 30,
                    height: 48,
                    text: 'Message',
                    textColor: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    isDisabled: false,
                    hasShadow: false,
                    isOutlined: false,
                    color: AppColors.secondary,
                  ),
                  CustomButton(
                    onPressed: () async {
                      final Uri telUri = Uri(
                        scheme: 'tel',
                        path: mobile,
                      );
                      if (await canLaunchUrl(telUri)) {
                        await launchUrl(telUri);
                      } else {
                        Get.snackbar("Error", "Unable to make a call");
                      }
                    },
                    icon: Icons.call,
                    width: MediaQuery.of(context).size.width * 0.45,
                    borderRadius: 30,
                    height: 48,
                    text: 'Call',
                    textColor: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    isDisabled: false,
                    hasShadow: false,
                    isOutlined: false,
                    color: AppColors.btnColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const PackagesWidget(),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Basic Info",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Dynamic Info Rows
              infoRow("User Type", userId),
             // infoRow("Created At", createdAt),
              BasicInfoWidget(),

            ],
          ),
        ),
      );
    });
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.text,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.secondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

