import 'package:abhivridhiapp/screens/home/widget/shipment_history_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/get_shipping_controller.dart';
import '../../../core/services/shipping_details_controller.dart';
import '../../../core/utils/app_color.dart';
import '../../track_order/track_order_screen.dart';

class TrackingCardList extends StatefulWidget {
  const TrackingCardList({super.key});

  @override
  _TrackingCardListState createState() => _TrackingCardListState();
}

class _TrackingCardListState extends State<TrackingCardList> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  final GetShippingController _shippingController = Get.put(
    GetShippingController(),
  );

  @override
  void initState() {
    super.initState();
    _shippingController.getShippingDetails();
  }

  void _navigateToDetails(String orderId) {
    final detailsController = Get.put(ShippingDetailsMoreController());
    detailsController.setShippingId(orderId);

    Get.to(
      () => const TrackOrderScreen(),
      arguments: {'orderId': orderId, 'showBottomNav': false},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_shippingController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (_shippingController.errorMessage.value.isNotEmpty) {
        return Center(
          child: Text('Error: ${_shippingController.errorMessage.value}'),
        );
      }

      final shippingData = _shippingController.getShipping.value.data ?? [];

      if (shippingData.isEmpty) {
        return const Center(child: Text('No shipping data available'));
      }

      return Column(
        children: [
          SizedBox(
            height: 265,
            child: PageView.builder(
              controller: _pageController,
              itemCount: shippingData.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final item = shippingData[index];
                final orderId = item.orderId ?? '';

                return GestureDetector(
                  onTap: () {
                    if (orderId.isNotEmpty) {
                      _navigateToDetails(orderId);
                    }
                  },
                  child: TrackingCard(
                    trackingNumber: orderId,
                    customer: item.name ?? 'N/A',
                    from: item.startLocation ?? 'N/A',
                    to: item.endLocation ?? 'N/A',
                    arrivalDate: item.date ?? 'N/A',
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(shippingData.length, (index) {
              return Container(
                width: currentIndex == index ? 14 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  shape: BoxShape.rectangle,
                  color:
                      currentIndex == index ? AppColors.primary : Colors.grey,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
        ],
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
