import 'package:abhivridhiapp/core/services/support_controller.dart';
import 'package:get/get.dart';

import '../services/profile_controller.dart';
import '../services/search_controller.dart';
import '../services/search_history_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
     Get.put(SupportController());

    // Get.put(HomeController());

  }
}
