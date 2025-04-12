import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_color.dart';
import 'circle_prograce_widget.dart';

class TrackingTimeStatus extends StatelessWidget {
  final String status;
  final String progress;

  const TrackingTimeStatus({
    super.key,
    required this.status,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.radio_button_checked, color: Colors.white),
                    DottedLine(
                      direction: Axis.vertical,
                      lineLength: 80,
                      dashColor: Colors.white,
                      dashLength: 4,
                      dashGapLength: 3,
                      lineThickness: 2,
                    ),
                    Icon(Icons.radio_button_checked, color: Colors.white),
                    DottedLine(
                      direction: Axis.vertical,
                      lineLength: 80,
                      dashColor: Colors.white,
                      dashLength: 4,
                      dashGapLength: 3,
                      lineThickness: 2,
                    ),
                    Icon(Icons.location_on, color: Colors.white),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildColumn("Status", status, isRight: true),
                    _buildColumn("Progress", "$progress%", isRight: true),
                    _buildColumn("Estimated Delivery",
                        "2PM (Mar,20,2025)", isRight: true),
                  ],
                )
              ],
            ),
            CircularProgressWidget(
              progress: double.tryParse(progress) ?? 0,
              size: 120,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(String title, String value, {bool isRight = false}) {
    return Column(
      crossAxisAlignment:
      isRight ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 130,
          child: Text(
            value,
            maxLines: 2,
            textAlign: isRight ? TextAlign.start : TextAlign.end,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}
