import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:abhivridhiapp/screens/track_order/widgets/product_tracking_details.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.08,),
              Container(
                height: MediaQuery.of(context).size.height*0.80,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ProductTrackingDetails(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
