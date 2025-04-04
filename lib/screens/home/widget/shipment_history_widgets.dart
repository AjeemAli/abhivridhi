import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_color.dart';
import '../../../widgets/custom_button.dart';

class TrackingCard extends StatelessWidget {
  final String trackingNumber;
  final String customer;
  final String from;
  final String to;
  final String arrivalDate;

  TrackingCard({
    required this.trackingNumber,
    required this.customer,
    required this.from,
    required this.to,
    required this.arrivalDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary, // Replace with AppColors.primary
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 25,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              _buildColumn("Tracking Number", trackingNumber),
              _buildColumn("Customer", customer),
              _buildColumn("Status", ""),
              CustomButton(
                onPressed: () => Get.toNamed('/face-id'),
                width: 120,
                borderRadius: 30,
                height: 42,
                text: 'In Transport',
                textColor: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                isDisabled: false,
                hasShadow: false,
                isOutlined: false,
                color: AppColors.btnColor, // Replace with AppColors.btnColor
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Icon(Icons.expand_circle_down_outlined, color: Colors.white),

              DottedLine(
                direction: Axis.vertical,
                lineLength: 120,
                dashColor: Colors.white,
                dashLength: 6,
                dashGapLength: 5,
                lineThickness: 2,
              ),

              Icon(Icons.expand_circle_down_outlined, color: Colors.white),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildColumn("From", from, isRight: true),
              _buildColumn("To", to, isRight: true),
              _buildColumn("Arrival Date", arrivalDate, isRight: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(String title, String value, {bool isRight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
          SizedBox(height: 5),
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}


