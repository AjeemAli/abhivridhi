import 'package:abhivridhiapp/screens/home/widget/offer_with_you.dart';
import 'package:abhivridhiapp/screens/home/widget/qr_search_container.dart';
import 'package:abhivridhiapp/screens/home/widget/stay_connect_widget.dart';
import 'package:abhivridhiapp/screens/home/widget/tracking_card_list.dart';
import 'package:abhivridhiapp/screens/home/widget/tracking_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/location_controller.dart';
import '../../core/utils/app_color.dart';
import '../tracking/tracking_history_view_screen.dart';

class HomeScreen extends GetView<LocationDataController> {
  final LocationDataController locationController = Get.put(
    LocationDataController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            collapsedHeight: 80,
            centerTitle: false,
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 4,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.error.withOpacity(0.3),
                child: Icon(Icons.location_on_outlined, color: AppColors.error),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notification_important_outlined,
                  color: AppColors.error,
                ),
              ),
            ],

            title: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Location",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  locationController.isLoading.value
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : Text(
                        locationController.locationText.value,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                ],
              ),
            ),

            // Make the appbar stretch to accommodate the search box
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                margin: const EdgeInsets.only(
                  top: 80,
                ), // Adjust based on your collapsedHeight
                child: const QRSearchBox(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom QR search widget
                    const SectionTitle("Shipment History"),
                    TrackingCardList(),
                    const SectionTitle("Stay Connected"),
                    StayConnectWidget(),
                    const SectionTitle("Offer For You"),
                    OfferWithYou(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionTitle("Tracking History"),
                        GestureDetector(
                          onTap:
                              () => Get.to(() => TrackingHistoryViewScreen()),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // TrackingHistory(),
                    TrackingHistoryScreen(),
                  ],
                ),
              ),
            ]),
          ),
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
