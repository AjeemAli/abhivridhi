import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/utils/app_color.dart';
import '../../../models/order_details_model.dart';
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
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // QR Code Section
            Center(
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  width: 120.0,
                  height: 120.0,
                  child: QrImageView(
                    data: _generateQRData(),
                    version: QrVersions.auto,
                    size: 120.0,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            // Product Info
            Text(
              shippingData.productName ?? 'No Product Name',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            Text(
              shippingData.orderId ?? 'No Order ID',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 24),
            // From-To Section
            TrackingProductFromTo(
              fromLocation: shippingData.startLocation ?? 'Origin Not Available',
              toLocation: shippingData.endLocation ?? 'Destination Not Available',
            ),

            const SizedBox(height: 24),
            // Status Section
            TrackingTimeStatus(
              status: shippingData.status ?? 'Status Not Available',
              progress: shippingData.progress ?? '0',
              time: shippingData.date as String? ?? 'Date Not Available',
            ),

            const SizedBox(height: 24),
            // Map Section
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const TrackMapWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

