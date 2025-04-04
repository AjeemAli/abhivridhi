import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_color.dart';
import '../../../widgets/custom_button.dart';

class OfferWithYou extends StatelessWidget {
  const OfferWithYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.cardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          CustomButton(
            onPressed: () {
              print("faceid");
              Get.toNamed('/face-id');} ,
            // onPressed: password.length >= 8 ? () {
            //   Get.offNamed('/face-id');
            // } : null,
            width: 100,
            borderRadius: 30,
            height: 42,
            text: 'Claim Now',
            textColor: AppColors.text.withOpacity(0.6),
            fontSize: 16,
            fontWeight: FontWeight.normal,
            isDisabled: false,
            //   isDisabled: password.length < 8,
            hasShadow: false,
            isOutlined: false,
            color:  AppColors.textDark,
          ),
          const Text(
            "Get a 12% Discount",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: AppColors.textDark),
          ),
           Text(
            "You can save up to 12% by using this code Fillo!",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.textDark.withOpacity(0.3)),
          ),
        ],
      ),
    );
  }
}
