import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_textfield.dart';

class SearchOrderScreen extends StatefulWidget {
  const SearchOrderScreen({super.key});

  @override
  State<SearchOrderScreen> createState() => _SearchOrderScreenState();
}

class _SearchOrderScreenState extends State<SearchOrderScreen> {
  final TextEditingController searchController = TextEditingController();
  List<String> recentSearches = ["John Doe", "ORD12345", "Laptop", "ORD67890"];
  List<Map<String, String>> searchResults = [];
  List<Map<String, String>> allOrders = [
    {"name": "John Doe", "orderId": "ORD12345", "product": "Laptop"},
    {"name": "Alice Smith", "orderId": "ORD67890", "product": "Smartphone"},
    {"name": "David Brown", "orderId": "ORD34567", "product": "Tablet"},
    {"name": "Emma Watson", "orderId": "ORD98765", "product": "Camera"},
  ];

  void onSearch(String query) {
    setState(() {
      searchResults = allOrders
          .where((order) =>
      order["name"]!.toLowerCase().contains(query.toLowerCase()) ||
          order["orderId"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void onScanQRCode() {
    // Simulated QR Scan (Replace with actual scan logic)
    setState(() {
      searchController.text = "ORD12345"; // Example scanned order ID
      onSearch("ORD12345");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Search Orders")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar with QR Code Scanner
            Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: AppColors.secondary)),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: searchController,
                      label: "Order ",
                      hint: "Enter name or order ID...",
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      borderColor: Colors.transparent,
                      enabled: true,
                      maxLines: 1,
                      onChanged: onSearch,

                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner, size: 30, color: Colors.blue),
                    onPressed: onScanQRCode,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Recent Searches
            const Text("Recent Searches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: recentSearches.map((search) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      searchController.text = search;
                      onSearch(search);
                    });
                  },
                  child: Chip(
                    label: Text(search),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () {
                      setState(() {
                        recentSearches.remove(search);
                      });
                    },

                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Search Results
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(child: Text("No matching orders found", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final order = searchResults[index];
                  return ListTile(
                    title: Text(order["name"]!),
                    subtitle: Text("Order ID: ${order["orderId"]!}"),
                    trailing: Text(order["product"]!),
                    onTap: () {
                      // Handle order selection (Navigate to order details)
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
