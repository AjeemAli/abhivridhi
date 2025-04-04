import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:abhivridhiapp/screens/dashboard/widget/custom_bottom_nav.dart';
import 'package:abhivridhiapp/screens/home/home_screen.dart';
import 'package:abhivridhiapp/screens/nearby_couriers/nearby_couriers_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../profile/user_profile_screen.dart';
import '../shipment/add_shipment_screen.dart';
import '../support/support_screen.dart';
import '../track_order/track_order_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    TrackOrderScreen(),
    TrackOrderScreen(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_selectIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add-shipment');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectIndex,
        onTap: (index) {
          setState(() {
            _selectIndex = index;
          });
        },
      ),
    );
  }
}
