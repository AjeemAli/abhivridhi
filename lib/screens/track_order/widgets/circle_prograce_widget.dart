import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  final double progress; // Progress percentage (0-100)
  final double size; // Size of the progress circle

  const CircularProgressWidget({
    super.key,
    required this.progress,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        // Circular Progress Indicator with a glow effect
        SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            value: progress / 100, // Convert percentage to 0-1
            strokeWidth: 12,
            backgroundColor: Colors.blue.shade400, // Soft shadow
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.background, // Adjust for glow effect
            ),
          ),
        ),

        // Centered Text (Status Percentage)
        Text(
          "${progress.toInt()}%", // Display percentage as an integer
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
