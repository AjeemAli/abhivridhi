import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_color.dart';
import '../../near_order_courier/near_courirer.dart';


class StayConnectWidget extends StatelessWidget {
  const StayConnectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.to(() => NearbyPlacesScreen()), // Corrected navigation
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.45,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.trackColor, // Replace with AppColors.primary
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Image.asset('assets/images/Logo.png', height: 80, width: 80),
                SizedBox(
                  width: 100,
                  child: const Text(
                    "Find Nearby Courier",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.45,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.trackColor, // Replace with AppColors.primary
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Image.asset('assets/images/Logo.png', height: 80, width: 80),
              SizedBox(
                width: 100,
                child: const Text(
                  "Calculate Shipment",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
