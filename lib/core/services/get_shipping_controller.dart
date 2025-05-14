import 'package:get/get.dart';

import '../../models/get_shipping_response.dart';
import 'api_services.dart';

class GetShippingController extends GetxController {
  final Rx<GetShippingResponse> getShipping = GetShippingResponse().obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final ApiService _apiService = ApiService();
  bool hasFetched = false;

  List<Data> get shippingList => getShipping.value.data ?? [];

  int get pendingCount => shippingList.where((s) => s.status?.toLowerCase() == 'pending').length;
  int get inProgressCount => shippingList.where((s) => s.status?.toLowerCase() == 'in-progress').length;
  int get deliveredCount => shippingList.where((s) => s.status?.toLowerCase() == 'delivered').length;

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
      final response = await _apiService.getRequest(
        'app/get-shipping-by-token',
        requiresAuth: true,
      );

      if (response == null) {
        throw Exception('No response received from server');
      }

      if (response is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      getShipping.value = GetShippingResponse.fromJson(response);
      hasFetched = true;

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  void refreshData() {
    hasFetched = false;
    getShippingDetails(force: true);
  }
}
