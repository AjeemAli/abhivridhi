import 'package:abhivridhiapp/screens/dashboard/widget/custom_bottom_nav.dart';
import 'package:abhivridhiapp/screens/shipment/add_shipment_screen.dart';
import 'package:abhivridhiapp/screens/support/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Make sure you import the Get package if not already included

import '../../../core/utils/app_color.dart';
import '../home/home_screen.dart';
import '../profile/user_profile_screen.dart';
import '../track_order/track_order_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectIndex = 0;
  DateTime? _lastBackPressed;

  final List<Widget> _pages = [
    HomeScreen(),
    const TrackOrderScreen(showBottomNav: true),
    AddShipmentScreen(),
    SupportScreen(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true; // exit app
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: _pages[_selectIndex],
        bottomNavigationBar: CustomBottomNav(
          currentIndex: _selectIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


