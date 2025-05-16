import 'package:abhivridhiapp/screens/home/widget/offer_with_you.dart';
import 'package:abhivridhiapp/screens/home/widget/qr_search_container.dart';
import 'package:abhivridhiapp/screens/home/widget/stay_connect_widget.dart';
import 'package:abhivridhiapp/screens/home/widget/tracking_card_list.dart';
import 'package:abhivridhiapp/screens/home/widget/tracking_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/get_shipping_controller.dart';
import '../../core/services/location_controller.dart';
import '../../core/services/search_history_controller.dart';
import '../../core/utils/app_color.dart';
import '../notification_screen.dart';
import '../shipment/add_shipment_screen.dart';
import '../track_order/track_order_screen.dart';
import '../tracking/tracking_history_view_screen.dart';

// class HomeScreen extends GetView<LocationDataController> {
//   final LocationDataController locationController = Get.put(
//     LocationDataController(),
//   );
//   final GetShippingController _shippingController = Get.put(
//     GetShippingController(),
//   );
//   final TrackingHistoryController _controller = Get.put(
//     TrackingHistoryController(),
//   );
//
//   Future<void> _refreshHome() async {
//     await _shippingController.getShipping();
//     await _controller.fetchTrackingHistory();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 120,
//             collapsedHeight: 80,
//             centerTitle: false,
//             pinned: true,
//             backgroundColor: AppColors.background,
//             elevation: 4,
//             leading: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CircleAvatar(
//                 radius: 15,
//                 backgroundColor: AppColors.error.withOpacity(0.3),
//                 child: Icon(Icons.location_on_outlined, color: AppColors.error),
//               ),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   Get.to(()=>NotificationScreen());
//                 },
//                 icon: Icon(
//                   Icons.notification_important_outlined,
//                   color: AppColors.error,
//                 ),
//               ),
//             ],
//
//             title: Obx(
//               () => Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Your Location",
//                     style: TextStyle(color: Colors.black, fontSize: 12),
//                   ),
//                   const SizedBox(height: 4),
//                   locationController.isLoading.value
//                       ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       )
//                       : Text(
//                         locationController.locationText.value,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.normal,
//                           fontSize: 13,
//                         ),
//                       ),
//                 ],
//               ),
//             ),
//
//             // Make the appbar stretch to accommodate the search box
//             flexibleSpace: FlexibleSpaceBar(
//               collapseMode: CollapseMode.pin,
//               background: Container(
//                 margin: const EdgeInsets.only(
//                   top: 80,
//                 ), // Adjust based on your collapsedHeight
//                 child: const QRSearchBox(),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate([
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 10,
//                 ),
//                 child: RefreshIndicator(
//                   onRefresh: _refreshHome,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Custom QR search widget
//                       const SectionTitle("Shipment History"),
//                       TrackingCardList(),
//                       const SectionTitle("Stay Connected"),
//                       StayConnectWidget(),
//                       const SectionTitle("Offer For You"),
//                       OfferWithYou(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SectionTitle("Tracking History"),
//                           GestureDetector(
//                             onTap:
//                                 () => Get.to(() => TrackingHistoryViewScreen()),
//                             child: Text(
//                               "View All",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.normal,
//                                 color: AppColors.secondary,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // TrackingHistory(),
//                       TrackingHistoryScreen(),
//                     ],
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }

class HomeScreen extends GetView<LocationDataController> {
  final LocationDataController locationController = Get.put(LocationDataController());
  final GetShippingController _shippingController = Get.put(GetShippingController());
  final TrackingHistoryController _controller = Get.put(TrackingHistoryController());

  Future<void> _refreshHome() async {
    await _shippingController.getShippingDetails(force: true);
    await _controller.fetchTrackingHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _refreshHome,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 126,
              collapsedHeight: 70,
              centerTitle: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary.withOpacity(0.8),
                        AppColors.primary.withOpacity(0.4),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
                  child: const QRSearchBox(),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: Icon(Icons.location_on_outlined, color: Colors.white),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => Get.to(() => NotificationScreen()),
                  icon: Badge(
                    child: Icon(Icons.notifications_outlined, color: Colors.white),
                  ),
                ),
              ],
              title: Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Location",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    locationController.isLoading.value
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      locationController.locationText.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2, // Allow address to wrap if long
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  _buildShipmentStatusCard(),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Recent Shipments", onTap: () {}),
                  const SizedBox(height: 8),
                  const TrackingCardList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Stay Connected", onTap: null),
                  const SizedBox(height: 8),
                  const StayConnectWidget(),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Special Offers", onTap: null),
                  const SizedBox(height: 8),
                  const OfferWithYou(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle("Tracking History", onTap: null),
                      TextButton(
                        onPressed: () => Get.to(() => TrackingHistoryViewScreen()),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TrackingHistoryScreen(),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildShipmentStatusCard() {
    return Obx(() {
      if (_shippingController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (_shippingController.errorMessage.value.isNotEmpty) {
        return Center(
          child: Text(
            _shippingController.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      // final shipments = _shippingController.shippingList;
      // final pending = _shippingController.pendingCount;
      // final inProgress = _shippingController.inProgressCount;
      // final delivered = _shippingController.deliveredCount;

      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Shipments",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     _buildStatusIndicator(
              //       count: pending,
              //       label: "Pending",
              //       color: Colors.orange,
              //     ),
              //     _buildStatusIndicator(
              //       count: inProgress,
              //       label: "In Transit",
              //       color: Colors.blue,
              //     ),
              //     _buildStatusIndicator(
              //       count: delivered,
              //       label: "Delivered",
              //       color: Colors.green,
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildStatusIndicator({required int count, required String label, required Color color}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.secondary),
          ],
        ],
      ),
    );
  }
}


class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
