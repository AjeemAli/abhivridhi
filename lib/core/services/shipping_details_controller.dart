
import 'package:get/get.dart';

import '../../models/shipment_details_response.dart';
import 'api_services.dart';

class ShippingDetailsMoreController extends GetxController {
  final RxList<ShippingDetailsResponse> shippingResponse = <ShippingDetailsResponse>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString noIdMessage = ''.obs;
  final ApiService _apiService = ApiService();
  bool hasFetched = false;
  String? id;

  // Method to set ID from previous screen
  void setShippingId(String shippingId) {
    id = shippingId;
    shippingDetails();
  }



  Future<void> shippingDetails({bool force = false}) async {
    // Check if we have an ID first
    if (id == null || id!.isEmpty) {
      noIdMessage.value = 'No shipping item selected';
      errorMessage.value = '';
      shippingResponse.clear();
      return;
    }

    if (hasFetched && !force) return;

    try {
      isLoading(true);
      errorMessage.value = '';
      noIdMessage.value = '';

      final response = await _apiService.getRequest('app/shipping/$id');
      print("API response: $response");

      if (response == null) {
        errorMessage.value = 'No data received from server';
        hasFetched = false;
        return;
      }

      if (response is List) {
        shippingResponse.assignAll(
            response.map((item) => ShippingDetailsResponse.fromJson(item)).toList()
        );
        hasFetched = true;
      } else if (response is Map<String, dynamic>) {
        // Handle case if API returns single object instead of list
        shippingResponse.assignAll([ShippingDetailsResponse.fromJson(response)]);
        hasFetched = true;
      } else {
        errorMessage.value = 'Invalid data format received';
        hasFetched = false;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load shipping details: ${e.toString()}';
      hasFetched = false;
    } finally {
      isLoading(false);
    }
  }

  // Clear all data
  void clearData() {
    id = null;
    shippingResponse.clear();
    errorMessage.value = '';
    noIdMessage.value = '';
    hasFetched = false;
  }
}