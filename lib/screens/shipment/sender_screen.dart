import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:abhivridhiapp/screens/shipment/parcel_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/add_shippment_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

// class SenderScreen extends StatefulWidget {
//   @override
//   _SenderScreenState createState() => _SenderScreenState();
// }
//
// class _SenderScreenState extends State<SenderScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   final AddShipmentController controller = Get.find<AddShipmentController>();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   Widget buildTextField({
//     required String label,
//     required String hint,
//     required TextEditingController controller,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscureText = false,
//     IconData? prefixIcon,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       spacing: 10,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           height: 46,
//           child: CustomTextField(
//             controller: controller,
//             label: label,
//             hint: hint,
//             fontWeight: FontWeight.normal,
//             obscureText: false,
//             keyboardType: TextInputType.text,
//             textInputAction: TextInputAction.next,
//             enabled: true,
//             maxLines: 1,
//             onSubmitted: (value) {  },
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: const Text('Sender Information'),
//         centerTitle: true,
//         bottom: TabBar(
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           indicatorColor: Colors.white,
//           controller: _tabController,
//           tabs: const [Tab(text: "Private"), Tab(text: "Company")],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildSenderForm(isCompany: false),
//           _buildSenderForm(isCompany: true),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSenderForm({required bool isCompany}) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         spacing: 10,
//         children: [
//           buildTextField(
//             label: isCompany ? 'Company Name' : 'Full Name',
//             hint: isCompany ? 'Enter company name' : 'Enter your name',
//             controller:
//                 controller.textControllers[AddShipmentController.nameIndex],
//           ),
//           buildTextField(
//             label: 'Address',
//             hint: 'Enter your address',
//             controller:
//                 controller.textControllers[AddShipmentController.toIndex],
//           ),
//           buildTextField(
//             label: 'Zip Code',
//             hint: 'Enter zip code',
//             controller: controller.zipController,
//             keyboardType: TextInputType.number,
//           ),
//           buildTextField(
//             label: 'Location',
//             hint: 'Enter location',
//             controller:
//                 controller.textControllers[AddShipmentController.fromIndex],
//             prefixIcon: Icons.location_on,
//           ),
//           buildTextField(
//             label: 'Phone',
//             hint: 'Enter phone number',
//             controller:
//                 controller.textControllers[AddShipmentController.phoneIndex],
//             keyboardType: TextInputType.phone,
//           ),
//           buildTextField(
//             label: 'Email',
//             hint: 'Enter email',
//             controller:
//                 controller.textControllers[AddShipmentController.emailIndex],
//             keyboardType: TextInputType.emailAddress,
//           ),
//           if (isCompany)
//             buildTextField(
//               label: 'GST Number',
//               hint: 'Enter GST number',
//               controller:
//                   controller.textControllers[AddShipmentController.gstIndex],
//               keyboardType: TextInputType.text,
//             ),
//           Text(
//             "Add At least one way for us notify the recipient",
//             textAlign: TextAlign.start,
//             maxLines: 3,
//             style: TextStyle(
//               fontSize: 13,
//               color: AppColors.secondary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             "If the recipient has the app we will add the parcel in their tab automatically",
//             textAlign: TextAlign.start,
//             maxLines: 3,
//             style: TextStyle(
//               fontSize: 13,
//               color: AppColors.secondary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Price",
//                 textAlign: TextAlign.start,
//                 maxLines: 3,
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: AppColors.text,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '₹${controller.price.value.toStringAsFixed(2)}',
//                 textAlign: TextAlign.start,
//                 maxLines: 3,
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: AppColors.text,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 20),
//           Obx(
//             () => CustomButton(
//               onPressed:
//                   controller.isLoading.value
//                       ? null
//                       : () => controller.addShipping(),
//               width: double.infinity,
//               borderRadius: 30,
//               height: 48,
//               text:
//                   controller.isLoading.value
//                       ? 'Processing...'
//                       : 'Add recipient',
//               textColor: AppColors.text,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               isDisabled: controller.isLoading.value,
//               hasShadow: false,
//               isOutlined: false,
//               color:
//                   controller.isLoading.value ? Colors.grey : AppColors.primary,
//               child:
//                   controller.isLoading.value
//                       ? Center(
//                         child: CircularProgressIndicator(color: Colors.white),
//                       )
//                       : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ShipmentFormScreen extends StatelessWidget {
  final ValueNotifier<String> senderType = ValueNotifier('Individual');
  final ValueNotifier<String> receiverType = ValueNotifier('Individual');
  final AddShipmentController controller = Get.find<AddShipmentController>();
  ShipmentFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Shipment Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sender Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRadioButtons(senderType),
            _buildFormSenderFields(senderType),

            const SizedBox(height: 20),

            const Text(
              "Receiver Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRadioButtons(receiverType),
            _buildFormReceiverFields(receiverType),

            const SizedBox(height: 20),

            CustomButton(
              onPressed: () {
                final nameSender =
                    controller
                        .textControllers[AddShipmentController.nameSenderIndex]
                        .text
                        .trim();
                final mobileSender =
                    controller
                        .textControllers[AddShipmentController
                            .mobileSenderIndex]
                        .text
                        .trim();
                final zipSender =
                    controller
                        .textControllers[AddShipmentController.zipSenderIndex]
                        .text
                        .trim();
                final addressSender =
                    controller
                        .textControllers[AddShipmentController
                            .addressSenderIndex]
                        .text
                        .trim();
                final officeSender =
                    controller
                        .textControllers[AddShipmentController
                            .officeSenderIndex]
                        .text
                        .trim();
                final emailSender =
                    controller
                        .textControllers[AddShipmentController.emailSenderIndex]
                        .text
                        .trim();
                final gstSender =
                    controller
                        .textControllers[AddShipmentController.gstSenderIndex]
                        .text
                        .trim();
                final nameReceiver =
                    controller
                        .textControllers[AddShipmentController
                            .nameReceiverIndex]
                        .text
                        .trim();
                final mobileReceiver =
                    controller
                        .textControllers[AddShipmentController
                            .mobileReceiverIndex]
                        .text
                        .trim();
                final zipReceiver =
                    controller
                        .textControllers[AddShipmentController.zipReceiverIndex]
                        .text
                        .trim();
                final addressReceiver =
                    controller
                        .textControllers[AddShipmentController
                            .addressReceiverIndex]
                        .text
                        .trim();
                final officeReceiver =
                    controller
                        .textControllers[AddShipmentController
                            .officeReceiverIndex]
                        .text
                        .trim();
                final emailReceiver =
                    controller
                        .textControllers[AddShipmentController
                            .emailReceiverIndex]
                        .text
                        .trim();

                // Debug print all values
                debugPrint('======= SHIPMENT FORM VALUES =======');
                debugPrint('Sender Details:');
                debugPrint('Name: $nameSender');
                debugPrint('Mobile: $mobileSender');
                debugPrint('ZIP: $zipSender');
                debugPrint('Address: $addressSender');
                debugPrint('Office: $officeSender');
                debugPrint('Email: $emailSender');
                debugPrint('GST: $gstSender');
                debugPrint('------------------------------------');
                debugPrint('Receiver Details:');
                debugPrint('Name: $nameReceiver');
                debugPrint('Mobile: $mobileReceiver');
                debugPrint('ZIP: $zipReceiver');
                debugPrint('Address: $addressReceiver');
                debugPrint('Office: $officeReceiver');
                debugPrint('Email: $emailReceiver');
                debugPrint('====================================');

                if (nameSender.isEmpty ||
                    mobileSender.isEmpty ||
                    zipSender.isEmpty ||
                    addressSender.isEmpty ||
                    nameReceiver.isEmpty ||
                    mobileReceiver.isEmpty ||
                    zipReceiver.isEmpty ||
                    addressReceiver.isEmpty) {
                  Get.snackbar(
                    'Missing Fields',
                    'Please fill all required sender and receiver details before proceeding.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                }

                // Additional format validation (optional)
                if (!RegExp(r'^\d{10}$').hasMatch(mobileSender) ||
                    !RegExp(r'^\d{10}$').hasMatch(mobileReceiver)) {
                  Get.snackbar(
                    'Invalid Mobile Number',
                    'Mobile number must be 10 digits.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.orangeAccent,
                    colorText: Colors.white,
                  );
                  return;
                }

                if (emailSender.isNotEmpty && !GetUtils.isEmail(emailSender)) {
                  Get.snackbar(
                    'Invalid Email',
                    'Please enter a valid sender email.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.orangeAccent,
                    colorText: Colors.white,
                  );
                  return;
                }

                if (emailReceiver.isNotEmpty &&
                    !GetUtils.isEmail(emailReceiver)) {
                  Get.snackbar(
                    'Invalid Email',
                    'Please enter a valid receiver email.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.orangeAccent,
                    colorText: Colors.white,
                  );
                  return;
                }

                // Navigate to the next screen if validation passes
                Get.to(() => ParcelScreen());
              },

              text: 'Proceed',
              color: AppColors.primary,
              textColor: Colors.white,
              width: double.infinity,
              height: 42,
              isDisabled: false,
              isOutlined: false,
              hasShadow: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButtons(ValueNotifier<String> typeNotifier) {
    return ValueListenableBuilder(
      valueListenable: typeNotifier,
      builder: (context, value, _) {
        return Row(
          children: [
            Radio<String>(
              value: 'Individual',
              groupValue: value,
              onChanged: (val) => typeNotifier.value = val!,
            ),
            const Text('Individual'),
            Radio<String>(
              value: 'Business',
              groupValue: value,
              onChanged: (val) => typeNotifier.value = val!,
            ),
            const Text('Business'),
          ],
        );
      },
    );
  }

  Widget _buildFormSenderFields(ValueNotifier<String> typeNotifier) {
    return ValueListenableBuilder(
      valueListenable: typeNotifier,
      builder: (context, value, _) {
        return Column(
          spacing: 10,
          children: [
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .nameSenderIndex],
              label: 'Name',
              hint: 'Enter name',
              prefixIcon: Icons.person,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.text,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .mobileSenderIndex],
              label: 'Mobile',
              hint: 'Enter mobile number',
              prefixIcon: Icons.phone,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.phone,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .zipSenderIndex],
              label: 'Zip Code',
              hint: 'Enter zip code',
              prefixIcon: Icons.location_on,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.number,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .addressSenderIndex],
              label: 'Address',
              hint: 'Enter address',
              prefixIcon: Icons.home,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 2,
              keyboardType: TextInputType.text,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .officeSenderIndex],
              label: 'Office Address',
              hint: 'Enter office address',
              prefixIcon: Icons.location_city,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 2,
              keyboardType: TextInputType.text,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .emailSenderIndex],
              label: 'Email',
              hint: 'Enter email',
              prefixIcon: Icons.email,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            if (value == 'Business')
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded to make sure TextField doesn't overflow
                  Expanded(
                    child: Obx(() {
                      return CustomTextField(
                        controller: controller.textControllers[AddShipmentController.gstSenderIndex],
                        errorText: controller.gstVerificationFailed.value
                            ? 'GST verification failed'
                            : null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your GST number';
                          }
                          // You can add a RegExp check for GST format here if needed
                          return null;
                        },
                        label: 'GST Number',
                        hint: 'Enter GST number',
                        prefixIcon: Icons.confirmation_number,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        enabled: true,
                        onChanged: (value) {
                          // Reset verification flags when GST number changes
                          if (controller.isGSTVerified.value || controller.gstVerificationFailed.value) {
                            controller.isGSTVerified.value = false;
                            controller.gstVerificationFailed.value = false;
                          }
                        },
                        onSubmitted: (_) {},
                      );
                    }),
                  ),

                  const SizedBox(width: 8),

                  Obx(() {
                    if (controller.isVerifyingGST.value) {
                      return const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      );
                    }

                    if (controller.isGSTVerified.value) {
                      return const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      );
                    }

                    return IconButton(
                      icon: const Icon(Icons.verified_user, color: AppColors.primary),
                      onPressed: controller.verifyGSTNumber,
                      tooltip: 'Verify GST',
                    );
                  }),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildFormReceiverFields(ValueNotifier<String> typeNotifier) {
    return ValueListenableBuilder(
      valueListenable: typeNotifier,
      builder: (context, value, _) {
        return Column(
          spacing: 10,
          children: [
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .nameReceiverIndex],
              label: 'Name',
              hint: 'Enter name',
              prefixIcon: Icons.person,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.text,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .mobileReceiverIndex],
              label: 'Mobile',
              hint: 'Enter mobile number',
              prefixIcon: Icons.phone,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.phone,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .zipReceiverIndex],
              label: 'Zip Code',
              hint: 'Enter zip code',
              prefixIcon: Icons.location_on,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.number,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .addressReceiverIndex],
              label: 'Address',
              hint: 'Enter address',
              prefixIcon: Icons.home,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 2,
              keyboardType: TextInputType.text,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .officeReceiverIndex],
              label: 'Office Address',
              hint: 'Enter office address',
              prefixIcon: Icons.location_city,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 2,
              keyboardType: TextInputType.text,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
            CustomTextField(
              controller:
                  controller.textControllers[AddShipmentController
                      .emailReceiverIndex],
              label: 'Email',
              hint: 'Enter email',
              prefixIcon: Icons.email,
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              enabled: true,
              onChanged: (_) {},
              onSubmitted: (_) {},
            ),
          ],
        );
      },
    );
  }
}
