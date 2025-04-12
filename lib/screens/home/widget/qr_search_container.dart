import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_color.dart';

class QRSearchBox extends StatelessWidget {
  const QRSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/search-order');
      },
      child: Container(
        height: 42,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            //SvgPicture.asset('assets/icons/qr.svg', height: 20, width: 20),
            Expanded(
              child: Text(
                "search shipping",
                style: TextStyle(fontSize: 14, color: AppColors.secondary),
              ),
            ),
            Icon(Icons.qr_code)
          ],
        ),
      ),
    );
  }
}
