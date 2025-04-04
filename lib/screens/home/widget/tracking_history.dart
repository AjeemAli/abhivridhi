import 'package:flutter/material.dart';

class TrackingHistory extends StatelessWidget {
  const TrackingHistory({super.key});

  final List<Map<String, String>> trackingData = const [
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
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.90,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: trackingData.length,
        itemBuilder: (context, index) {
          final data = trackingData[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.local_shipping, color: Colors.white),
              ),
              title: Text(
                data["trackingNumber"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${data["from"]} → ${data["to"]}\nArrival: ${data["arrivalDate"]}",
              ),
              // trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              // onTap: () {
              //   // Handle tap action (e.g., navigate to tracking details page)
              // },
            ),
          );
        },
      ),
    );
  }
}
