  import 'package:abhivridhiapp/core/utils/app_color.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  
  import '../../core/services/search_controller.dart';
  import '../../core/services/shipping_details_controller.dart';
import '../../models/search_reponse.dart';
import '../track_order/track_order_screen.dart';
  
  class SearchOrderScreen extends StatelessWidget {
    SearchOrderScreen({super.key});
  
    final SearchOrderController _searchController = Get.put(
      SearchOrderController(),
    );
    final TextEditingController _textEditingController = TextEditingController();
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Search Orders'),
          actions: [
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: _searchController.scanQRCode,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchField(context),
              const SizedBox(height: 20),
              _buildRecentSearchesHeader(),
              const SizedBox(height: 8),
              _buildRecentSearchesList(),
              const SizedBox(height: 20),
              _buildSearchResults(),
            ],
          ),
        ),
      );
    }
  
    Widget _buildSearchField(context) {
      return Obx(
            () => TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            labelText: 'Order ID',
            hintText: 'Enter order ID...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.isSearching.value
                ? const Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
                : _textEditingController.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _textEditingController.clear();
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )
                : IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () {
                // Handle QR scan action here
                print("QR Scanner tapped");
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (text) {
            // Trigger a rebuild to update the suffix icon
            _searchController.update(); // or use setState() if not in Obx
          },
          onSubmitted: (query) {
            _searchController.searchOrder(query);
            _textEditingController.clear();
          },
        ),
      );
    }
  
  
    Widget _buildRecentSearchesHeader() {
      return Obx(
        () =>
            _searchController.recentSearches.isNotEmpty
                ? Row(
                  children: [
                    const Text(
                      'Recent Searches',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _searchController.clearRecentSearches,
                      child: const Text(
                        'Clear All',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
                : const SizedBox(),
      );
    }
  
    Widget _buildRecentSearchesList() {
      return Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  _searchController.recentSearches
                      .map(
                        (search) => Chip(
                          label: Text(search),
                          onDeleted:
                              () => _searchController.removeRecentSearch(search),
                          deleteIcon: const Icon(Icons.close, size: 16),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      );
    }
  
    Widget _buildSearchResults() {
      return Obx(() {
        if (_searchController.isLoading.value) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }
  
        if (_searchController.errorMessage.value.isNotEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                _searchController.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
  
        if (_searchController.searchResult.value != null) {
          return _buildOrderCard(_searchController.searchResult.value!);
        }
  
        return const Expanded(
          child: Center(
            child: Text(
              'Search for orders by ID',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      });
    }
    void _navigateToDetails(String orderId) {
      final detailsController = Get.put(ShippingDetailsMoreController());
      detailsController.setShippingId(orderId);

      // Navigate to details screen

      Get.to(
              () =>  TrackOrderScreen(
                orderId:orderId ,
              ),
          arguments: {
            'orderId': orderId,
            'showBottomNav': false,
          });

      // Get.to(TrackOrderScreen(), arguments: orderId, 'showBottomNav': false,);
    }


    Widget _buildOrderCard(SearchData order) {
      if (order.orderId == null) {
        return const Center(
          child: Text(
            'No order found for the provided ID.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
      }
  
      return InkWell(
        onTap: () => _navigateToDetails(order.orderId ?? ''),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order #${order.orderId}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildDetailRow('Product', order.productName ?? 'N/A'),
              _buildDetailRow('From', order.startLocation ?? 'N/A'),
              _buildDetailRow('To', order.endLocation ?? 'N/A'),
              _buildDetailRow('Date', order.date ?? 'N/A'),
              _buildDetailRow('Price', '₹${order.price ?? 'N/A'}'),
            ],
          ),
        ),
      );
    }
  
  
    Widget _buildDetailRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                '$label:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
          ],
        ),
      );
    }
  
    Color _getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'delivered':
          return Colors.green;
        case 'shipped':
          return Colors.blue;
        case 'processing':
          return Colors.orange;
        case 'cancelled':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }
  }
  
  class OrderDetailsScreen extends StatelessWidget {
    final SearchData order;
  
    const OrderDetailsScreen({super.key, required this.order});
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Order #${order.orderId}')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailCard(),
              const SizedBox(height: 20),
              _buildTrackingInfo(),
            ],
          ),
        ),
      );
    }
  
    Widget _buildDetailCard() {
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem('Order ID', order.orderId),
              _buildDetailItem('Status', order.status),
              _buildDetailItem('Product', order.productName),
              _buildDetailItem('Price', '₹${order.price}'),
              _buildDetailItem('Date', order.date),
              _buildDetailItem('From', order.startLocation),
              _buildDetailItem('To', order.endLocation),
              _buildDetailItem('Weight', order.weight),
            ],
          ),
        ),
      );
    }
  
    Widget _buildDetailItem(String label, String? value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Text(value ?? 'N/A')),
          ],
        ),
      );
    }
  
    Widget _buildTrackingInfo() {
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tracking Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildTrackingStep('Order Placed', isCompleted: true),
              _buildTrackingStep('Processing', isCompleted: true),
              _buildTrackingStep(
                'Shipped',
                isCompleted:
                    order.status == 'Shipped' || order.status == 'Delivered',
              ),
              _buildTrackingStep(
                'Delivered',
                isCompleted: order.status == 'Delivered',
              ),
            ],
          ),
        ),
      );
    }
  
    Widget _buildTrackingStep(String text, {required bool isCompleted}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(text),
          ],
        ),
      );
    }
  }
