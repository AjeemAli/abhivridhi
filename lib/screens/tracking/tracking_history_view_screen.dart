import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../home/widget/tracking_history.dart';

class TrackingHistoryViewScreen extends StatelessWidget {
  const TrackingHistoryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text("Tracking History"),),
      body: SafeArea(child: SingleChildScrollView(child: TrackingHistoryScreen(),)),
    );
  }
}