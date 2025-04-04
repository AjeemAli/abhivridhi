import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class TrackingProductFromTo extends StatelessWidget {
  const TrackingProductFromTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.btnColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // FROM Location
          _buildColumn("From", '54, Kumar Para Dhaka', isRight: false),

          // Dotted Line in Between
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.radio_button_checked,
                color: Colors.white,
              ), // Start Point
              DottedLine(
                direction: Axis.vertical,
                lineLength: 25,
                dashColor: Colors.white,
                dashLength: 4,
                dashGapLength: 3,
                lineThickness: 2,
              ),
              Icon(Icons.location_on, color: Colors.white), // End Point
            ],
          ),

          // TO Location
          _buildColumn("To", "54, Kumar Para Sylhet", isRight: true),
        ],
      ),
    );
  }

  Widget _buildColumn(String title, String value, {bool isRight = false}) {
    return Column(
      crossAxisAlignment:
          isRight ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(title, style: TextStyle(fontSize: 12, color: AppColors.textDark)),
        SizedBox(height: 5),
        SizedBox(
          width: 130,
          child: Text(
            value,
            maxLines: 2,
            textAlign: isRight ? TextAlign.start : TextAlign.end,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
