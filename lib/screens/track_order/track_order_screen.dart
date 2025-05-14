import 'package:abhivridhiapp/core/services/order_details_controller.dart';
import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:abhivridhiapp/screens/track_order/widgets/product_tracking_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/shipping_details_controller.dart';

// class TrackOrderScreen extends StatelessWidget {
//   final bool showBottomNav;
//   const TrackOrderScreen( {super.key,this.showBottomNav = true});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(OrderDetailsController());
//
//     // Get orderId and nav flag from arguments
//     // final args = Get.arguments as Map<String, dynamic>?;
//     // final orderId = args?['orderId'] as String?;
//     // final showBottomNavArg = args?['showBottomNav'] ?? showBottomNav;
//
//     // if (orderId != null) {
//     //   controller.setShippingId(orderId);
//     // }
//
//     Widget body = Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(title: Text("Order Details"),),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.08),
//               Container(
//                 height: MediaQuery.of(context).size.height*0.9 ,
//                 decoration: BoxDecoration(
//                   color: AppColors.primary,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Obx(() {
//                   if (controller.isLoading.value) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//
//                   if (controller.errorMessage.value.isNotEmpty) {
//                     return Center(child: Text(controller.errorMessage.value));
//                   }
//
//
//                   if (controller.orderDetails.value.orderData == null) {
//                     return const Center(child: Text('Shipping data not available'));
//                   }
//
//                   return ProductTrackingDetails(
//                     shippingData: controller.orderDetails.value!.orderData!,
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     return showBottomNavArg
//         ? WillPopScope(
//       onWillPop: () async {
//         // Handle back press in dashboard
//         return true;
//       },
//       child: body,
//     )
//         : body;
//   }
// }

class TrackOrderScreen extends StatelessWidget {
  final bool showBottomNav;
  final String orderId;

  const TrackOrderScreen({
    super.key,
    this.showBottomNav = true,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());

    return FutureBuilder(
      future: controller.fetchOrderDetails(orderId),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: const Text("Order Details")),
          body: SafeArea(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }

              final orderData = controller.orderDetails.value.orderData;
              if (orderData == null) {
                return const Center(child: Text('Shipping data not available'));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ProductTrackingDetails(
                      shippingData: orderData,
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}