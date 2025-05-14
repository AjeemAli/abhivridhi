import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

// class TrackingProductFromTo extends StatelessWidget {
//   final String fromLocation;
//   final String toLocation;
//
//   const TrackingProductFromTo({
//     super.key,
//     required this.fromLocation,
//     required this.toLocation,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: AppColors.btnColor,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildColumn("From", fromLocation, isRight: false),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.radio_button_checked, color: Colors.white),
//               DottedLine(
//                 direction: Axis.vertical,
//                 lineLength: 25,
//                 dashColor: Colors.white,
//                 dashLength: 4,
//                 dashGapLength: 3,
//                 lineThickness: 2,
//               ),
//               Icon(Icons.location_on, color: Colors.white),
//             ],
//           ),
//           _buildColumn("To", toLocation, isRight: true),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildColumn(String title, String value, {bool isRight = false}) {
//     return Column(
//       crossAxisAlignment:
//       isRight ? CrossAxisAlignment.start : CrossAxisAlignment.end,
//       children: [
//         Text(title, style: TextStyle(fontSize: 12, color: AppColors.textDark)),
//         SizedBox(height: 5),
//         SizedBox(
//           width: 130,
//           child: Text(
//             value,
//             maxLines: 2,
//             textAlign: isRight ? TextAlign.start : TextAlign.end,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textDark,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


class TrackingProductFromTo extends StatelessWidget {
  final String fromLocation;
  final String toLocation;

  const TrackingProductFromTo({
    super.key,
    required this.fromLocation,
    required this.toLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildColumn("From", fromLocation),
          Column(
            children: const [
              Icon(Icons.radio_button_checked, color: Colors.blue),
              DottedLine(direction: Axis.vertical, lineLength: 25),
              Icon(Icons.location_on, color: Colors.red),
            ],
          ),
          _buildColumn("To", toLocation),
        ],
      ),
    );
  }

  Widget _buildColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 4),
        SizedBox(
          width: 100,
          child: Text(value, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
