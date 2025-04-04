import 'package:flutter/material.dart';
import 'package:abhivridhiapp/screens/home/widget/shipment_history_widgets.dart';

import '../../../core/utils/app_color.dart';

class TrackingCardList extends StatefulWidget {
  TrackingCardList({super.key});

  @override
  _TrackingCardListState createState() => _TrackingCardListState();
}

class _TrackingCardListState extends State<TrackingCardList> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Map<String, String>> trackingData = [
    {
      "trackingNumber": "#1234567879",
      "customer": "Fillo Design",
      "from": "Dhaka",
      "to": "Sylhet",
      "arrivalDate": "02/04/25",
    },
    {
      "trackingNumber": "#9876543210",
      "customer": "John Doe",
      "from": "New York",
      "to": "Los Angeles",
      "arrivalDate": "10/06/25",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 265,
          child: PageView.builder(
            controller: _pageController,
            itemCount: trackingData.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return TrackingCard(
                trackingNumber: trackingData[index]["trackingNumber"]!,
                customer: trackingData[index]["customer"]!,
                from: trackingData[index]["from"]!,
                to: trackingData[index]["to"]!,
                arrivalDate: trackingData[index]["arrivalDate"]!,
              );
            },
          ),
        ),
        const SizedBox(height: 10), // Spacing between PageView and dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(trackingData.length, (index) {
            return Container(
              width: currentIndex == index ? 14 : 8,
              height: currentIndex == index ? 8 : 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle,
                color: currentIndex == index ? AppColors.primary : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
