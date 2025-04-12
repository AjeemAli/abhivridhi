import 'package:get/get.dart';

import '../../models/profile_model.dart';
import 'api_services.dart';

class ProfileController extends GetxController {
  final Rx<ProfileModel> profile = ProfileModel().obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final ApiService _apiService = ApiService();

  bool hasFetched = false;


  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile({bool force = false}) async {
    if (hasFetched && !force) return;

    try {
      isLoading(true);
      errorMessage('');
      print("Starting profile fetch...");

      final response = await _apiService.getRequest(
        'app/get_user',
        requiresAuth: true,
      );

      print("Profile fetch response: $response");

      if (response != null && response is Map<String, dynamic>) {
        profile.value = ProfileModel.fromJson(response);
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
    profile.value = ProfileModel();
    errorMessage('');
    hasFetched = false;
    fetchProfile();
  }
}

