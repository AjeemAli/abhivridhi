import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/shipment/parcel_screen.dart';
import '../../screens/shipment/sender_screen.dart';
import '../utils/app_color.dart';
import 'api_services.dart';
import 'location_controller.dart';

class AddShipmentController extends GetxController {

  var selectedVehicle = ''.obs;
  var selectedLabourOptions = ''.obs;
  var isFragileHandling = false.obs;
  var isSameDayDelivery = false.obs;
  var isCashOnDelivery = false.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var deliveryLatitude = 0.0.obs;
  var deliveryLongitude = 0.0.obs;
  var isVerifyingGST = false.obs;
  var isGSTVerified = false.obs;
  var gstVerificationFailed = false.obs;



  void selectVehicle(String vehicle) {
    if (selectedVehicle.value == vehicle) {
      selectedVehicle.value = '';
    } else {
      selectedVehicle.value = vehicle;
    }
  }


  void toggleFragileHandling() {
    isFragileHandling.toggle();
    if (isFragileHandling.value) {
      price.value += 40;
    } else {
      price.value -= 40;
    }
  }

  void toggleSameDayDelivery() {
    isSameDayDelivery.toggle();
    if (isSameDayDelivery.value) {
      price.value += 100;
    } else {
      price.value -= 100;
    }
  }

  void toggleCashOnDelivery() {
    isCashOnDelivery.toggle();
    if (isCashOnDelivery.value) {
      price.value += 20;
    } else {
      price.value -= 20;
    }
  }

  bool hasAdditionalServices() {
    return isNextDayDelivery.value ||
        isOrderTracking.value ||
        isOversize.value ||
        isFragileHandling.value ||
        isSameDayDelivery.value ||
        isCashOnDelivery.value;
  }

  @override
  void onInit() {
    super.onInit();
    autoFillFromLocation();
  }

  // Text controllers
  final List<TextEditingController> textControllers = List.generate(
    15,
        (_) => TextEditingController(),
  );

  // Mapping indices for better readability
  static const int fromIndex = 0;
  static const int toIndex = 1;
  static const int nameSenderIndex = 2;
  static const int mobileSenderIndex = 3;
  static const int zipSenderIndex = 4;
  static const int addressSenderIndex = 5;
  static const int officeSenderIndex = 6;
  static const int emailSenderIndex = 7;
  static const int nameReceiverIndex = 8;
  static const int mobileReceiverIndex = 9;
  static const int zipReceiverIndex = 10;
  static const int addressReceiverIndex = 11;
  static const int officeReceiverIndex = 12;
  static const int emailReceiverIndex = 13;
  static const int gstSenderIndex = 14;



  final TextEditingController zipController = TextEditingController();
  final TextEditingController pickupLabourController = TextEditingController();
  final deliveryLabourController = TextEditingController();



  void clearFromLocation() {
    textControllers[AddShipmentController.fromIndex].clear();
    Get.find<PlaceSearchController>().selectedFromLocation.clear();
  }

  void clearToLocation() {
    textControllers[AddShipmentController.toIndex].clear();
    Get.find<PlaceSearchController>().selectedToLocation.clear();
  }

  void updatePickupLabour(String value) {
    if (value.isNotEmpty) {
      int val = int.tryParse(value) ?? 0;
      if (val >= 1 && val <= 5) {
        selectedLabourOptions.value = val.toString();
        calculatePrice();
      }
    } else {
      selectedLabourOptions.value = 0.toString();
    }
  }


  // Reactive variables
  final weight = 2.0.obs;
  final packageSize = 200.0.obs;
  final basePrice = 50.0;
  final price = 0.0.obs;
  final totalPrice = 0.0.obs;
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
  final isVisible = false.obs;
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
      double additionalCost =
      weight.value > 2
          ? (weight.value - 2) * (nextDayDeliveryCost.value * 0.10)
          : 0;
      totalPrice += nextDayDeliveryCost.value + additionalCost;
    }

    // Add cost for Order Tracking if enabled
    if (isOrderTracking.value) {
      totalPrice += orderTrackingCost.value;
    }

    // Extra charge for package size over 200cm
    if (packageSize.value > 200) {
      double additionalSizeCost =
      packageSize.value > 500
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
      showSnackbar(
        "Missing Information",
        "Please enter the starting location.",
      );
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


// Api Function of Add shipping
  Future<void> addShipping() async {
    if (!isValidInput()) return;
    final requestData = {
      "pickup_location": textControllers[fromIndex].text.trim(),
      "delivery_location": textControllers[toIndex].text.trim(),
      "vehicle_type": selectedVehicle.value,
      "labour_type": selectedLabourOptions.value,
      "courier_type": selectedOption.value,
      "weight": weight.value,
      "price": price.value,
      "name_sender": textControllers[nameSenderIndex].text.trim(),
      "mobile_sender": textControllers[mobileSenderIndex].text.trim(),
      "zip_sender": textControllers[zipSenderIndex].text.trim(),
      "address_sender": textControllers[addressSenderIndex].text.trim(),
      "office_sender": textControllers[officeSenderIndex].text.trim(),
      "email_sender": textControllers[emailSenderIndex].text.trim(),
      "name_receiver": textControllers[nameReceiverIndex].text.trim(),
      "mobile_receiver": textControllers[mobileReceiverIndex].text.trim(),
      "zip_receiver": textControllers[zipReceiverIndex].text.trim(),
      "address_receiver": textControllers[addressReceiverIndex].text.trim(),
      "office_receiver": textControllers[officeReceiverIndex].text.trim(),
      "email_receiver": textControllers[emailReceiverIndex].text.trim(),

      "home_delivery": hasAdditionalServices(),
      "order_tracking": isOrderTracking.value,
      "over_sized": isOversize.value,
      "fragile_handling": isFragileHandling.value,
      "same_day_delivery": isSameDayDelivery.value,
      "cash_on_delivery": isCashOnDelivery.value,
      "total_amount": price.value,
    };


    try {
      isLoading.value = true;
      final response = await _apiService.postRequest(
        "app/add_shipping",
        data: requestData,
        requiresAuth: true,
      );

      if (response != null) {
        showSnackbar("Success", "Shipping added successfully.");
        Get.offAllNamed('/dashboard');
      } else {
        showSnackbar("Error", "Failed to add shipment. Try again.");
      }
    } catch (e) {
      showSnackbar("Error", e.toString());
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Api Function of GST Verification
  Future<void> verifyGSTNumber() async {
    final gstin = textControllers[gstSenderIndex].text.trim();

    if (gstin.isEmpty) {
      showErrorSnackbar('Empty GSTIN', 'Please enter GSTIN number');
      return;
    }

    try {
      isVerifyingGST.value = true;
      gstVerificationFailed.value = false;

      final response = await _apiService.postRequest(
        "verify-gst",
        data: {"gstin": gstin},
        requiresAuth: false,
      );

      print('GST verification Response: $response');

      if (response['success'] == true && response['data']['valid'] == true) {
        isGSTVerified.value = true;
        gstVerificationFailed.value = false;

        showSuccessSnackbar('Verified', response['data']['message'] ?? 'GSTIN verified successfully');

        // Access other useful details
        final gstData = response['data'];
        print('Legal Name: ${gstData['legal_name_of_business']}');
        print('Trade Name: ${gstData['trade_name_of_business']}');
        print('Address: ${gstData['principal_place_address']}');

        // You can store the data to use later if needed
        // e.g., controller.legalName.value = gstData['legal_name_of_business'];

      } else {
        isGSTVerified.value = false;
        gstVerificationFailed.value = true;

        showErrorSnackbar('Invalid GSTIN', response['data']['message'] ?? 'GSTIN verification failed');
      }

    } catch (e) {
      print('GST verification Error: $e');
      isGSTVerified.value = false;
      gstVerificationFailed.value = true;
      showErrorSnackbar('Error', 'GSTIN verification failed: ${e.toString()}');
    } finally {
      isVerifyingGST.value = false;
    }
  }



  void showSnackbar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }
  // Show error snackbar
  void showErrorSnackbar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
  }

  // Show success snackbar
  void showSuccessSnackbar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
  }

  Future<void> autoFillFromLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showSnackbar("Location Error", "Enable location services.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
          showSnackbar("Location Error", "Location permission denied.");
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        final address = "${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
        textControllers[fromIndex].text = address;
        latitude.value = position.latitude; // Store latitude
        longitude.value = position.longitude; // Store longitude
      }
    } catch (e) {
      showSnackbar("Error", "Failed to get location: $e");
    }
  }
  // In AddShipmentController
  bool isServiceSelected(String serviceName) {
    switch (serviceName) {
      case "Order Tracking":
        return isOrderTracking.value;
      case "Oversize Package":
        return isOversize.value;
      case "Fragile Handling":
        return isFragileHandling.value;
      case "Same Day Delivery":
        return isSameDayDelivery.value;
      case "Cash on Delivery":
        return isCashOnDelivery.value;
      default:
        return false;
    }
  }

  void toggleService(String serviceName) {
    switch (serviceName) {
      case "Order Tracking":
        toggleOrderTracking();
        break;
      case "Oversize Package":
        toggleOversize();
        break;
      case "Fragile Handling":
        toggleFragileHandling();
        break;
      case "Same Day Delivery":
        toggleSameDayDelivery();
        break;
      case "Cash on Delivery":
        toggleCashOnDelivery();
        break;
    }
  }
}






















// class AddShipmentController extends GetxController {
//   // Text controllers
//   final List<TextEditingController> textControllers =
//   List.generate(7, (_) => TextEditingController());
//
//   static const int fromIndex = 0;
//   static const int toIndex = 1;
//   static const int nameIndex = 2;
//   static const int addressIndex = 3;
//   static const int phoneIndex = 4;
//   static const int emailIndex = 5;
//   static const int gstIndex = 6;
//
//   final TextEditingController zipController = TextEditingController();
//
//   // Reactive variables
//   final weight = 2.0.obs;
//   final packageSize = 200.0.obs;
//   final basePrice = 50.0;
//   final price = 0.0.obs;
//   final selectedOption = "Parcel".obs;
//
//   final nextDayDeliveryCost = 50.0.obs;
//   final orderTrackingCost = 30.0.obs;
//   final oversizeCost = 30.0.obs;
//
//   final isNextDayDelivery = false.obs;
//   final isOrderTracking = false.obs;
//   final isOversize = false.obs;
//
//   final isLoading = false.obs;
//   final isVisible = false.obs;
//
//   final ApiService _apiService = Get.put(ApiService());
//
//   @override
//   void onClose() {
//     for (var controller in textControllers) {
//       controller.dispose();
//     }
//     zipController.dispose();
//     super.onClose();
//   }
//
//   void toggleWeightSelection() => isVisible.toggle();
//
//   void calculatePrice() {
//     double totalPrice = basePrice;
//
//     if (weight.value > 2) {
//       totalPrice += (weight.value - 2) * (basePrice * 0.10);
//       if (!isNextDayDelivery.value) {
//         isNextDayDelivery.value = true;
//       }
//     }
//
//     if (isNextDayDelivery.value) {
//       double additionalCost =
//       weight.value > 2 ? (weight.value - 2) * (nextDayDeliveryCost.value * 0.10) : 0;
//       totalPrice += nextDayDeliveryCost.value + additionalCost;
//     }
//
//     if (isOrderTracking.value) {
//       totalPrice += orderTrackingCost.value;
//     }
//
//     if (packageSize.value > 200) {
//       double additionalSizeCost = packageSize.value > 500
//           ? ((packageSize.value - 500) / 50) * (oversizeCost.value * 0.02)
//           : 0;
//       totalPrice += oversizeCost.value + additionalSizeCost;
//
//       if (packageSize.value > 300 && !isOversize.value) {
//         isOversize.value = true;
//       }
//     }
//
//     if (isOversize.value) {
//       totalPrice += oversizeCost.value;
//     }
//
//     price.value = totalPrice;
//   }
//
//   void onWeightChanged(double value) {
//     weight.value = value;
//     calculatePrice();
//   }
//
//   void onPackageSizeChanged(double value) {
//     packageSize.value = value;
//     calculatePrice();
//   }
//
//   void toggleNextDayDelivery() {
//     isNextDayDelivery.toggle();
//     calculatePrice();
//   }
//
//   void toggleOrderTracking() {
//     isOrderTracking.toggle();
//     calculatePrice();
//   }
//
//   void toggleOversize() {
//     isOversize.toggle();
//     calculatePrice();
//   }
//
//   bool isValidInput() {
//     if (textControllers[fromIndex].text.trim().isEmpty) {
//       showSnackbar("Missing Information", "Please enter the starting location.");
//       return false;
//     }
//     if (textControllers[toIndex].text.trim().isEmpty) {
//       showSnackbar("Missing Information", "Please enter the destination.");
//       return false;
//     }
//     if (textControllers[nameIndex].text.trim().isEmpty) {
//       showSnackbar("Missing Information", "Please enter the recipient name.");
//       return false;
//     }
//     if (textControllers[phoneIndex].text.trim().length < 10) {
//       showSnackbar("Invalid Phone", "Enter a valid phone number.");
//       return false;
//     }
//     if (zipController.text.trim().isEmpty) {
//       showSnackbar("Missing Zip", "Please enter the zip code.");
//       return false;
//     }
//     return true;
//   }
//
//   bool hasAdditionalServices() {
//     if (!isNextDayDelivery.value && !isOrderTracking.value && !isOversize.value) {
//       showSnackbar("No Additional Service", "You have not selected any additional services.");
//       return false;
//     }
//     Get.to(() => SenderScreen());
//     return true;
//   }
//
//   void printAllValues() {
//     debugPrint("Shipping From: ${textControllers[fromIndex].text}");
//     debugPrint("Shipping To: ${textControllers[toIndex].text}");
//     debugPrint("Selected Option: ${selectedOption.value}");
//     debugPrint("Weight: ${weight.value} kg");
//     debugPrint("Package Size: ${packageSize.value} cm");
//     debugPrint("Total Price: ₹${price.value.toStringAsFixed(2)}");
//     debugPrint("Next-Day Delivery: ${isNextDayDelivery.value ? '₹${nextDayDeliveryCost.value}' : 'No'}");
//     debugPrint("Order Tracking: ${isOrderTracking.value ? '₹${orderTrackingCost.value}' : 'No'}");
//     debugPrint("Oversize Charge: ${isOversize.value ? '₹${oversizeCost.value}' : 'No'}");
//   }
//
//   Future<void> addShipping() async {
//     if (!isValidInput()) return;
//
//     final requestData = {
//       "name": textControllers[nameIndex].text.trim(),
//       "price": price.value.toStringAsFixed(2),
//       "start_location": textControllers[fromIndex].text.trim(),
//       "end_location": textControllers[toIndex].text.trim(),
//       "weight": "${weight.value}kg",
//       "package_size": "${packageSize.value}cm",
//       "address": textControllers[addressIndex].text.trim(),
//       "phone": textControllers[phoneIndex].text.trim(),
//       "email": textControllers[emailIndex].text.trim(),
//       "Zip_code": zipController.text.trim(),
//       "type": selectedOption.value,
//       "next_day_delivery": isNextDayDelivery.value ? nextDayDeliveryCost.value.toString() : "0",
//       "order_tracking": isOrderTracking.value ? orderTrackingCost.value.toString() : "0",
//       "oversize": isOversize.value ? oversizeCost.value.toString() : "0",
//     };
//
//     try {
//       isLoading.value = true;
//       final response = await _apiService.postRequest(
//         "app/add_shipping",
//         data: requestData,
//         requiresAuth: true,
//       );
//
//       if (response != null) {
//         showSnackbar("Success", "Shipping added successfully.");
//         Get.offAllNamed('/dashboard'); // Redirect to Dashboard screen
//       } else {
//         showSnackbar("Error", "Failed to add shipment. Try again.");
//       }
//     } catch (e) {
//       showSnackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void showSnackbar(String title, String message) {
//     Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
//   }
// }
