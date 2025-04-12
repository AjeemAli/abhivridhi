import 'package:abhivridhiapp/models/support_model.dart';
import 'package:get/get.dart';

import 'api_services.dart';

class SupportController extends GetxController {
  final RxList<SupportResponse> supportList = <SupportResponse>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final ApiService _apiService = ApiService();
  bool hasFetched = false;

  @override
  void onInit() {
    super.onInit();
    getSupportDetails();
  }

  Future<void> getSupportDetails({bool force = false}) async {
    if (hasFetched && !force) return;
    try {
      isLoading(true);
      errorMessage('');
      final response = await _apiService.getRequest('app/get_support');
      print("API response: $response");

      if (response != null && response is List) {
        supportList.assignAll(
            (response as List).map((item) => SupportResponse.fromJson(item)).toList()
        );
        hasFetched = true;
      } else {
        errorMessage.value = 'Invalid data format received';
        hasFetched = false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      hasFetched = false;
    } finally {
      isLoading(false);
    }
  }
}

