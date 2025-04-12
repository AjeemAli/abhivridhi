import 'package:get/get.dart';

import '../../models/get_shipping_response.dart';
import 'api_services.dart';

class GetShippingController extends GetxController {
  final Rx<GetShippingResponse> getShipping = GetShippingResponse().obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final ApiService _apiService = ApiService();

  bool hasFetched = false;


  @override
  void onInit() {
    super.onInit();
    getShippingDetails();
  }

  Future<void> getShippingDetails({bool force = false}) async {
    if (hasFetched && !force) return;

    try {
      isLoading(true);
      errorMessage('');
      print("Starting Get Shipping fetch...");

      final response = await _apiService.getRequest(
        'app/get-shipping-by-token',
        requiresAuth: true,
      );

      print("Profile fetch response: $response");

      if (response != null && response is Map<String, dynamic>) {
        getShipping.value = GetShippingResponse.fromJson(response);
        hasFetched = true;
      } else {
        throw Exception('Invalid response format or empty data');
      }
    } catch (e) {
      errorMessage.value = e is Exception ? e.toString() : 'Failed to load profile';
      print('Error fetching profile: $e');
    } finally {
      isLoading(false);
    }
  }

  void clearProfile() {
    getShipping.value = GetShippingResponse();
    errorMessage('');
    hasFetched = false;
    getShippingDetails();
  }
}