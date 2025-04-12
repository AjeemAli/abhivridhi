import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/search_history_response.dart';
import 'api_services.dart';

class TrackingHistoryController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());

  final RxList<HistoryData> historyList = <HistoryData>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasMore = true.obs;
  final int _perPage = 10;
  int _currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchTrackingHistory();
  }

  Future<void> fetchTrackingHistory({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      hasMore.value = true;
    }

    if (!hasMore.value && !refresh) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _apiService.getRequest(
        'app/searched-orders',
        requiresAuth: true,
      );

      if (response != null) {
        final trackingResponse = TrackingHistoryResponse.fromJson(response);

        if (trackingResponse.status == true) {
          final newData = trackingResponse.historyData ?? [];

          // Prevent duplicates
          final existingIds = historyList.map((e) => e.orderId).toSet();
          final filteredData = newData
              .where((item) => !existingIds.contains(item.orderId))
              .toList();

          if (refresh) {
            historyList.assignAll(filteredData);
          } else {
            historyList.addAll(filteredData);
          }

          // 🛑 Prevent further API calls if no new data was added
          if (filteredData.isEmpty || filteredData.length < _perPage) {
            hasMore.value = false;
          } else {
            _currentPage++;
          }
        } else {
          throw Exception(trackingResponse.message ?? 'Failed to load history');
        }
      } else {
        throw Exception('No response from server');
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> refreshHistory() async {
    await fetchTrackingHistory(refresh: true);
  }

  Future<void> addToHistory(String orderId) async {
    try {
      await _apiService.postRequest(
        'app/searched-orders',
        requiresAuth: true,
        data: {'order_id': orderId},
      );
      await refreshHistory();
    } catch (e) {
      debugPrint('Error adding to tracking history: $e');
    }
  }

  Future<void> deleteOrderFromHistory(String orderId) async {
    try {
      final response = await _apiService.deleteRequest(
        'app/delete_search_histories',
        requiresAuth: true,
        data: {'order_id': orderId},
      );

      if (response != null && response['status'] == true) {
        historyList.removeWhere((item) => item.orderId == orderId);
      } else {
        errorMessage.value = response?['message'] ?? 'Failed to delete order';
      }
    } catch (e) {
      errorMessage.value = 'Failed to delete order: $e';
    }
  }
}
