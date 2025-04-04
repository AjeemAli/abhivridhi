import 'package:abhivridhiapp/screens/home/widget/offer_with_you.dart';
import 'package:abhivridhiapp/screens/home/widget/stay_connect_widget.dart';
import 'package:abhivridhiapp/screens/home/widget/tracking_card_list.dart';
import 'package:abhivridhiapp/screens/home/widget/tracking_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_color.dart';
import '../../widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 130,
            collapsedHeight: 60,
            centerTitle: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 4,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Location",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                Text(
                  "Location",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.error.withOpacity(0.2),
                child: Icon(Icons.location_on_outlined, color: AppColors.error),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notification_important_outlined,
                  color: Colors.grey,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 48,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('/search-order');
                    },
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.secondary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: AppColors.secondary,
                            ),
                          ),
                          Icon(Icons.qr_code),
                        ],
                      ),
                    ),
                  ),

                  // CustomTextField(
                  //   controller: _searchController,
                  //   label: "Search",
                  //   hint: "Search for services",
                  //   prefixIcon: Icons.search_sharp,
                  //   suffixIcon: Icons.qr_code_scanner, // Scan Icon
                  //   obscureText: false,
                  //   keyboardType: TextInputType.text,
                  //   textInputAction: TextInputAction.search,
                  //   enabled: true,
                  //   maxLines: 1,
                  //   onSuffixTap: () {
                  //     // Handle scan icon tap
                  //   },
                  // ),
                ),
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
                  spacing: 10,
                  children: [
                    const Text(
                      "Shipment History",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TrackingCardList(),
                    const Text(
                      "Stay Connected",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StayConnectWidget(),
                    const Text(
                      "Offer For You",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    OfferWithYou(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tracking History",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "view all",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                    TrackingHistory(),
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
