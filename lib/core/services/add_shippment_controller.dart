import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/shipment/parcel_screen.dart';
import '../../screens/shipment/sender_screen.dart';
import 'api_services.dart';

class AddShipmentController extends GetxController {
  // Text controllers
  final List<TextEditingController> textControllers = List.generate(7, (_) => TextEditingController());

  // Mapping indices for better readability
  static const int fromIndex = 0;
  static const int toIndex = 1;
  static const int nameIndex = 2;
  static const int addressIndex = 3;
  static const int phoneIndex = 4;
  static const int emailIndex = 5;
  static const int gstIndex = 6;

  final TextEditingController zipController = TextEditingController();

  // Reactive variables
  final weight = 2.0.obs;
  final packageSize = 200.0.obs;
  final basePrice = 50.0;
  final price = 0.0.obs;
  final selectedOption = "Parcel".obs;

  // Additional service costs
  final nextDayDeliveryCost = 50.0.obs;
  final orderTrackingCost = 30.0.obs;
  final oversizeCost = 30.0.obs;

  // Service selections
  final isNextDayDelivery = false.obs;
  final isOrderTracking = false.obs;
  final isOversize = false.obs;

  final isLoading = false.obs;
  final isVisible = false.obs; // Controls weight slider visibility
  final ApiService _apiService = Get.put(ApiService());

  @override
  void onClose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    zipController.dispose();
    super.onClose();
  }

  // Toggle weight selection visibility
  void toggleWeightSelection() => isVisible.toggle();

  // **Calculate total price based on weight, package size, and selected services**
  void calculatePrice() {
    double totalPrice = basePrice;

    // Extra charge for weight over 2kg
    if (weight.value > 2) {
      totalPrice += (weight.value - 2) * (basePrice * 0.10);

      // **Auto-enable Next-Day Delivery if weight exceeds 2kg**
      if (!isNextDayDelivery.value) {
        isNextDayDelivery.value = true;
      }
    }

    // Add cost for Next-Day Delivery
    if (isNextDayDelivery.value) {
      double additionalCost = weight.value > 2 ? (weight.value - 2) * (nextDayDeliveryCost.value * 0.10) : 0;
      totalPrice += nextDayDeliveryCost.value + additionalCost;
    }

    // Add cost for Order Tracking if enabled
    if (isOrderTracking.value) {
      totalPrice += orderTrackingCost.value;
    }

    // Extra charge for package size over 200cm
    if (packageSize.value > 200) {
      double additionalSizeCost = packageSize.value > 500
          ? ((packageSize.value - 500) / 50) * (oversizeCost.value * 0.02)
          : 0;
      totalPrice += oversizeCost.value + additionalSizeCost;

      // **Auto-enable Oversize Charge if size exceeds 300cm**
      if (packageSize.value > 300 && !isOversize.value) {
        isOversize.value = true;
      }
    }

    // Add cost for Oversize if enabled
    if (isOversize.value) {
      totalPrice += oversizeCost.value;
    }

    price.value = totalPrice;
  }

  // **Update weight and recalculate price**
  void onWeightChanged(double value) {
    weight.value = value;
    calculatePrice();
  }

  // **Update package size and recalculate price**
  void onPackageSizeChanged(double value) {
    packageSize.value = value;
    calculatePrice();
  }

  // **Toggle services manually and recalculate price**
  void toggleNextDayDelivery() {
    isNextDayDelivery.toggle();
    calculatePrice();
  }

  void toggleOrderTracking() {
    isOrderTracking.toggle();
    calculatePrice();
  }

  void toggleOversize() {
    isOversize.toggle();
    calculatePrice();
  }

  // **Validate input fields**
  bool isValidInput() {
    if (textControllers[fromIndex].text.trim().isEmpty) {
      showSnackbar("Missing Information", "Please enter the starting location.");
      return false;
    }
    if (textControllers[toIndex].text.trim().isEmpty) {
      showSnackbar("Missing Information", "Please enter the destination.");
      return false;
    }
    if (weight.value < 1) {
      showSnackbar("Invalid Weight", "Please select a valid weight.");
      return false;
    }
    Get.to(() => ParcelScreen());
    return true;
  }

  // **Check if additional services are selected**
  bool hasAdditionalServices() {
    if (!isNextDayDelivery.value && !isOrderTracking.value && !isOversize.value) {
      showSnackbar("No Additional Service", "You have not selected any additional services.");
      return false;
    }
    Get.to(() => SenderScreen());
    return true;
  }

  // **Debugging utility**
  void printAllValues() {
    debugPrint("Shipping From: ${textControllers[fromIndex].text}");
    debugPrint("Shipping To: ${textControllers[toIndex].text}");
    debugPrint("Selected Option: ${selectedOption.value}");
    debugPrint("Weight: ${weight.value} kg");
    debugPrint("Package Size: ${packageSize.value} cm");
    debugPrint("Total Price: ₹${price.value.toStringAsFixed(2)}");
    debugPrint("Next-Day Delivery: ${isNextDayDelivery.value ? '₹${nextDayDeliveryCost.value}' : 'No'}");
    debugPrint("Order Tracking: ${isOrderTracking.value ? '₹${orderTrackingCost.value}' : 'No'}");
    debugPrint("Oversize Charge: ${isOversize.value ? '₹${oversizeCost.value}' : 'No'}");
  }

  // **Submit shipping details**
  Future<void> addShipping() async {
    if (!isValidInput()) return;

    final requestData = {
      "name": textControllers[nameIndex].text.trim(),
      "price": price.value.toStringAsFixed(2),
      "start_location": textControllers[fromIndex].text.trim(),
      "end_location": textControllers[toIndex].text.trim(),
      "weight": "${weight.value}kg",
      "package_size": "${packageSize.value}cm",
      "address": textControllers[addressIndex].text.trim(),
      "phone": textControllers[phoneIndex].text.trim(),
      "email": textControllers[emailIndex].text.trim(),
      "Zip_code": zipController.text.trim(),
      "type": selectedOption.value,
      "next_day_delivery": isNextDayDelivery.value ? nextDayDeliveryCost.value.toString() : "0",
      "order_tracking": isOrderTracking.value ? orderTrackingCost.value.toString() : "0",
      "oversize": isOversize.value ? oversizeCost.value.toString() : "0",
    };

    try {
      isLoading.value = true;
      final response = await _apiService.postRequest(
        "admin/add_shipping",
        data: requestData,
        requiresAuth: true,
      );

      if (response != null) {
        showSnackbar("Success", "Shipping added successfully.");
        Get.offAllNamed('/cart');
      } else {
        showSnackbar("Error", "Failed to add shipment. Try again.");
      }
    } catch (e) {
      showSnackbar("Error", e.toString());
    }
    finally{
      isLoading.value = false; // Stop loading
    }
  }

  // **Show snackbar notifications**
  void showSnackbar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }
}
