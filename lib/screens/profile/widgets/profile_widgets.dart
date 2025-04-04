import 'package:abhivridhiapp/screens/profile/widgets/packages_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_color.dart';
import '../../../widgets/custom_button.dart';
import 'basic_info_widget.dart';

class ProfileWidgets extends StatelessWidget {
  const ProfileWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          const Text(
            "Vikrant Bhavani",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const Text(
            "User ID: @bhavani12",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onPressed: () {},
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
                onPressed: () {},
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
          SizedBox(height: 20),
          PackagesWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Basic info",
                maxLines: 1,

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          BasicInfoWidget(),
          SizedBox(height: 100,),
        ],
      ),
    );
  }
}
