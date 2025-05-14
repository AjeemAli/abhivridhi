import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/search_history_controller.dart';
import '../../../core/services/shipping_details_controller.dart';
import '../../../models/search_history_response.dart';
import '../../search/search_order_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/search_history_controller.dart';
import '../../../models/search_history_response.dart';
import '../../search/search_order_screen.dart';
import '../../track_order/track_order_screen.dart';

class TrackingHistoryScreen extends StatelessWidget {
  TrackingHistoryScreen({super.key});

  final TrackingHistoryController _controller = Get.put(
    TrackingHistoryController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Initial loading state
      if (_controller.isLoading.value && _controller.historyList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      // Error state
      if (_controller.errorMessage.value.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _controller.refreshHistory,
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      // Empty state
      if (_controller.historyList.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              'No Tracking Data Available',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
      }

      // Success state with data
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Prevent conflict with parent scroll
        itemCount: _controller.historyList.length +
            (_controller.hasMore.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _controller.historyList.length) {
            _controller.fetchTrackingHistory();
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final history = _controller.historyList[index];
          return _buildHistoryItem(history);
        },
      );
    });
  }

  Widget _buildHistoryItem(HistoryData history) {
    final orderId = history.orderId ?? 'N/A';
    final date = history.searchedAt != null
        ? _formatDate(history.searchedAt!)
        : 'Date not available';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          if (orderId.isNotEmpty) {
            _navigateToDetails(orderId);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(Icons.history, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #$orderId',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tracked on $date',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  if (history.orderId != null) {
                    _controller.deleteOrderFromHistory(history.orderId!);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _navigateToDetails(String orderId) {
    final detailsController = Get.put(ShippingDetailsMoreController());
    detailsController.setShippingId(orderId);

    Get.to(
          () =>  TrackOrderScreen(
        orderId:orderId ,
      ),
      arguments: {'orderId': orderId, 'showBottomNav': false},
    );
  }


  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}

