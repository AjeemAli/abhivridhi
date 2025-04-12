import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/utils/app_color.dart';
import '../../../models/shipment_details_response.dart';
import '../track_map_widget.dart';
import 'order_details_from_to.dart';
import 'tracking_time_status.dart';

class ProductTrackingDetails extends StatelessWidget {
  final OrderData shippingData;

  const ProductTrackingDetails({super.key, required this.shippingData});


  String _generateQRData() {
    return jsonEncode({
      'order_id': shippingData.orderId,
      'product_name': shippingData.productName,
      'tracking_number': shippingData.orderId,
      'from': shippingData.startLocation,
      'to': shippingData.endLocation,
      'status': shippingData.status,
      'deep_link': 'yourapp://track-order/${shippingData.orderId}'
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ClipOval(
                child: Container(
                  color: Colors.white, // Background color of the circle
                  width: 120.0,
                  height: 120.0,
                  child: QrImageView(
                    data: _generateQRData(),
                    version: QrVersions.auto,
                    size: 120.0,
                    backgroundColor: Colors.white, // Inside QR background
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Text(
              shippingData.productName ?? 'Product Name Not Available',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark),
            ),
            Text(
              shippingData.orderId ?? 'Order ID Not Available',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark),
            ),
            const SizedBox(height: 20),
            TrackingProductFromTo(
              fromLocation: shippingData.startLocation ?? 'Origin Not Available',
              toLocation: shippingData.endLocation ?? 'Destination Not Available',
            ),
            const SizedBox(height: 20),
            TrackingTimeStatus(
              status: shippingData.status ?? 'Status Not Available',
              progress: shippingData.progress ?? '0',
            ),
            const SizedBox(height: 20),
            const TrackMapWidget(),
          ],
        ),
      ),
    );
  }
}
