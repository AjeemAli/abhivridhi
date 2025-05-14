
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../models/order_details_model.dart';
import 'api_services.dart';

class OrderDetailsController extends GetxController {
  final Rx<OrderDetailsModel> orderDetails = OrderDetailsModel().obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final ApiService _apiService = ApiService();

  bool hasFetched = false;

  Future<void> fetchOrderDetails(String orderID, {bool force = false}) async {
    if (hasFetched && !force) return;

    try {
      isLoading(true);
      errorMessage('');
      debugPrint("Fetching Order Details for ID: $orderID");

      final response = await _apiService.getRequest(
        'app/shipping/$orderID',
        requiresAuth: true,
      );

      debugPrint("Order details response: $response");

      if (response != null && response is Map<String, dynamic>) {
        orderDetails.value = OrderDetailsModel.fromJson(response);
        hasFetched = true;
      } else {
        throw Exception('Invalid response format or empty data');
      }
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint('Error fetching order details: $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  void clearOrderDetails() {
    orderDetails.value = OrderDetailsModel();
    errorMessage('');
    hasFetched = false;
  }
}
