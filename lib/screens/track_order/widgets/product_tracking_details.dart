import 'package:flutter/material.dart';
import '../../../core/utils/app_color.dart';
import '../track_map_widget.dart';
import 'order_details_from_to.dart';
import 'tracking_time_status.dart';

class ProductTrackingDetails extends StatelessWidget {
  ProductTrackingDetails({super.key});

  final List<Map<String, String>> trackingData = [
    {
      "trackingNumber": "#1234567879",
      "customer": "Fillo Design",
      "from": "Dhaka",
      "to": "Sylhet",
      "arrivalDate": "02/04/25",
    },
    {
      "trackingNumber": "#9876543210",
      "customer": "John Doe",
      "from": "New York",
      "to": "Los Angeles",
      "arrivalDate": "10/06/25",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/Logo.png',
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Samsung 24’’ LED monitor",
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark),
            ),
            const Text(
              "#123135461235",
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark),
            ),
            const SizedBox(height: 20),
            const TrackingProductFromTo(),
            const SizedBox(height: 20),
            const TrackingTimeStatus(),
            const SizedBox(height: 20),
            const TrackMapWidget(),
          ],
        ),
      ),
    );
  }
}
