import 'package:abhivridhiapp/screens/shipment/parcel_screen.dart';
import 'package:abhivridhiapp/screens/shipment/sender_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/add_shippment_controller.dart';
import '../../core/services/location_controller.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

// class AddShipmentScreen extends StatefulWidget {
//   @override
//   State<AddShipmentScreen> createState() => _AddShipmentScreenState();
// }
//
// class _AddShipmentScreenState extends State<AddShipmentScreen> {
//   final AddShipmentController controller = Get.put(AddShipmentController());
//   final locationController = Get.put(PlaceSearchController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(title: const Text('Ready Shipment'), centerTitle: true),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             spacing: 10,
//             children: [
//               _buildLabel('Shipping from'),
//               Column(
//                 spacing: 10,
//                 children: [
//                   CustomTextField(
//                     controller:
//                         controller.textControllers[AddShipmentController
//                             .fromIndex],
//                     onChanged:
//                         locationController
//                             .fetchFromSuggestions, // Use specific function
//                     label: 'Location',
//                     hint: 'Enter starting location',
//                     prefixIcon: Icons.location_on,
//                     textInputAction: TextInputAction.next,
//                     obscureText: false,
//                     maxLines: 1,
//                     keyboardType: TextInputType.text,
//                     enabled: true,
//                     onSubmitted: (value) {},
//                   ),
//                   Obx(
//                     () => ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: locationController.fromSuggestions.length,
//                       itemBuilder: (context, index) {
//                         final suggestion =
//                             locationController.fromSuggestions[index];
//                         return ListTile(
//                           title: Text(suggestion['description']),
//                           onTap: () {
//                             print("Selected: ${suggestion['description']}");
//                             controller
//                                 .textControllers[AddShipmentController
//                                     .fromIndex]
//                                 .text = suggestion['description'];
//                             locationController.fromSuggestions.clear();
//                             FocusScope.of(context).unfocus();
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 6),
//
//               _buildLabel('Shipping to'),
//               Column(
//                 spacing: 10,
//                 children: [
//                   CustomTextField(
//                     controller:
//                         controller.textControllers[AddShipmentController
//                             .toIndex],
//                     onChanged:
//                         locationController
//                             .fetchToSuggestions, // Use specific function
//                     label: 'Location',
//                     hint: 'Enter destination',
//                     prefixIcon: Icons.location_on,
//                     textInputAction: TextInputAction.done,
//                     obscureText: false,
//                     maxLines: 1,
//                     keyboardType: TextInputType.text,
//                     enabled: true,
//                     onSubmitted: (value) {},
//                   ),
//                   Obx(
//                     () => ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: locationController.toSuggestions.length,
//                       itemBuilder: (context, index) {
//                         final suggestion =
//                             locationController.toSuggestions[index];
//                         return ListTile(
//                           title: Text(suggestion['description']),
//                           onTap: () {
//                             print("Selected: ${suggestion['description']}");
//                             controller
//                                 .textControllers[AddShipmentController.toIndex]
//                                 .text = suggestion['description'];
//                             locationController.toSuggestions.clear();
//                             FocusScope.of(context).unfocus();
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//
//               _buildLabel('Shipping Options'),
//
//               // Only wrap necessary parts inside Obx
//               _buildShippingOption(),
//
//               const SizedBox(height: 20),
//               CustomButton(
//                 onPressed: () {
//                   final fromText =
//                       controller
//                           .textControllers[AddShipmentController.fromIndex]
//                           .text
//                           .trim();
//                   final toText =
//                       controller
//                           .textControllers[AddShipmentController.toIndex]
//                           .text
//                           .trim();
//                   final deliveryType = controller.selectedOption.value;
//                   final weightSize = controller.weight.value;
//                   final priceSize = controller.price.value;
//
//                   if (fromText.isEmpty ||
//                       toText.isEmpty ||
//                       deliveryType.isEmpty) {
//                     Get.snackbar(
//                       'Missing Fields',
//                       'Please fill all required fields before proceeding.',
//                       snackPosition: SnackPosition.BOTTOM,
//                       backgroundColor: Colors.redAccent,
//                       colorText: Colors.white,
//                     );
//                   } else {
//                     // Navigate to the next screen and pass data
//                     Get.to(
//                       () => ParcelScreen(),
//                       arguments: {
//                         'from': fromText,
//                         'to': toText,
//                         'deliveryType': deliveryType,
//                         'weight': controller.weight.value,
//                         'price': controller.price.value,
//                       },
//                     );
//                   }
//                 },
//                 text: 'Proceed',
//                 color: AppColors.primary,
//                 textColor: Colors.white,
//                 width: double.infinity,
//                 height: 42,
//                 isDisabled: false,
//                 isOutlined: false,
//                 hasShadow: true,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.normal,
//         color: AppColors.text,
//       ),
//     );
//   }
//
//   Widget _buildShippingOption() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.secondary),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.mail_outline_rounded, size: 26),
//               const SizedBox(width: 10),
//               const Text(
//                 "Delivery Type",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//
//           // Use Obx to make the radio buttons reactive
//           Obx(
//             () => Row(
//               children: [
//                 Row(
//                   children: [
//                     Radio<String>(
//                       value: "Parcel",
//                       groupValue: controller.selectedOption.value,
//                       onChanged: (value) {
//                         controller.selectedOption.value = value!;
//                       },
//                     ),
//                     const Text("Parcel"),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Radio<String>(
//                       value: "Letter",
//                       groupValue: controller.selectedOption.value,
//                       onChanged: (value) {
//                         controller.selectedOption.value = value!;
//                       },
//                     ),
//                     const Text("Letter"),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "Letters up to 2kg that are not traceable. Delivery to mailbox in 5 days or next business day.",
//             style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Obx(
//                   () => CustomButton(
//                     onPressed: () {},
//                     text:
//                         controller.weight.value <= 2
//                             ? 'Price: ₹${controller.basePrice.toStringAsFixed(2)}'
//                             : 'Price: ₹${controller.price.value.toStringAsFixed(2)}',
//                     color: AppColors.primary,
//                     textColor: AppColors.background,
//                     width: 100,
//                     height: 42,
//                     isDisabled: false,
//                     isOutlined: false,
//                     hasShadow: true,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(width: 10),
//
//               // Wrap only the icon inside Obx
//               Obx(
//                 () => GestureDetector(
//                   onTap: controller.toggleWeightSelection,
//                   child: CircleAvatar(
//                     backgroundColor: AppColors.primary,
//                     child: Icon(
//                       controller.isVisible.value
//                           ? Icons.keyboard_arrow_up
//                           : Icons.keyboard_arrow_down,
//                       color: AppColors.background,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 10),
//
//           // Only update relevant part inside Obx
//           Obx(() {
//             if (!controller.isVisible.value) return SizedBox();
//             return Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Select Weight Range',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//
//                   // Only updating the weight text inside Obx
//                   Obx(
//                     () => Text(
//                       'Weight: ${controller.weight.value.toStringAsFixed(1)} kg',
//                     ),
//                   ),
//
//                   // Only updating Slider inside Obx
//                   Obx(
//                     () => Slider(
//                       value: controller.weight.value,
//                       min: 2,
//                       max: 100,
//                       divisions: 33,
//                       label: '${controller.weight.value.toStringAsFixed(1)} kg',
//                       onChanged: (value) => controller.onWeightChanged(value),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

class AddShipmentScreen extends StatelessWidget {
  final AddShipmentController controller = Get.put(AddShipmentController());
  final locationController = Get.put(PlaceSearchController());
  AddShipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Ready Shipment'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              _buildLabel('Pickup Location'),
              Column(
                spacing: 10,
                children: [
                  CustomTextField(
                    controller: controller.textControllers[AddShipmentController.fromIndex],
                    onChanged: (value) {
                      locationController.fetchFromSuggestions(value);
                    },
                    label: 'Location',
                    hint: 'Enter starting location',
                    prefixIcon: Icons.location_on,
                    textInputAction: TextInputAction.next,
                    obscureText: false,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    enabled: true,
                    onSubmitted: (value) {},
                  ),

                  Obx(() {
                    return locationController.fromSuggestions.isNotEmpty
                        ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: locationController.fromSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = locationController.fromSuggestions[index];
                        return ListTile(
                          title: Text(suggestion['description']),
                          onTap: () async {
                            final placeId = suggestion['place_id'];
                            await locationController.setFromLocation(placeId);

                            controller.textControllers[AddShipmentController.fromIndex].text =
                                locationController.selectedFromLocation['address'] ?? '';

                            locationController.fromSuggestions.clear();
                            FocusScope.of(context).unfocus();
                          },
                        );
                      },
                    )
                        : SizedBox.shrink(); // hide if no suggestion
                  }),

                ],
              ),

              // New Multiple Vehicle Selection Section
              _buildLabel('Select Vehicle(s)'),
              _buildSingleVehicleOptions(),
              const SizedBox(height: 10),

              // New Multiple Labour Options Section
              _buildLabel('Labour Services'),
              _buildLabourInputField('Pickup Labour (Max 5)', controller.pickupLabourController),

              _buildLabel('Delivery Location'),
              Column(
                spacing: 10,
                children: [
                  CustomTextField(
                    controller: controller.textControllers[AddShipmentController.toIndex],
                    onChanged: (value) {
                      locationController.fetchToSuggestions(value);
                    },
                    label: 'Location',
                    hint: 'Enter destination',
                    prefixIcon: Icons.location_on,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    enabled: true,
                    onSubmitted: (value) {},
                  ),

                  Obx(() {
                    return locationController.toSuggestions.isNotEmpty
                        ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: locationController.toSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = locationController.toSuggestions[index];
                        return ListTile(
                          title: Text(suggestion['description']),
                          onTap: () async {
                            final placeId = suggestion['place_id'];
                            await locationController.setToLocation(placeId);

                            controller.textControllers[AddShipmentController.toIndex].text =
                                locationController.selectedToLocation['address'] ?? '';

                            locationController.toSuggestions.clear();
                            FocusScope.of(context).unfocus();
                          },
                        );
                      },
                    )
                        : SizedBox.shrink();
                  }),

                ],
              ),

              _buildLabel('Shipping Options'),
              _buildShippingOption(),

              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                    final fromDetails = locationController.selectedFromLocation;
                    final toDetails = locationController.selectedToLocation;

                    final fromAddress = fromDetails['address'];
                    final fromLat = fromDetails['lat'];
                    final fromLng = fromDetails['lng'];

                    final toAddress = toDetails['address'];
                    final toLat = toDetails['lat'];
                    final toLng = toDetails['lng'];

                    final deliveryType = controller.selectedOption.value;
                    final weightSize = controller.weight.value;
                    final priceSize = controller.price.value;
                    final selectedVehicles = controller.selectedVehicle;
                    final labourOptions = controller.selectedLabourOptions;

                    debugPrint('======= FORM VALUES =======');
                    debugPrint('From: $fromAddress [$fromLat, $fromLng]');
                    debugPrint('To: $toAddress [$toLat, $toLng]');
                    debugPrint('Delivery Type: $deliveryType');
                    debugPrint('Weight: $weightSize kg');
                    debugPrint('Price: ₹$priceSize');
                    debugPrint('Vehicle: $selectedVehicles');
                    debugPrint('Labour: $labourOptions');
                    debugPrint('===========================');

                    if (fromAddress == null ||
                        toAddress == null ||
                        deliveryType.isEmpty ||
                        selectedVehicles.isEmpty) {
                      Get.snackbar(
                        'Missing Fields',
                        'Please fill all required fields before proceeding.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    } else {
                      // You can send full data to API or next screen
                      Get.to(() => ShipmentFormScreen());
                    }

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
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.text,
      ),
    );
  }

  Widget _buildSingleVehicleOptions() {
    return Obx(
          () => Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _buildSelectableOption(
            icon: Icons.directions_bike,
            label: 'Bike',
            isSelected: controller.selectedVehicle.value == 'Bike',
            onTap: () => controller.selectVehicle('Bike'),
          ),
          _buildSelectableOption(
            icon: Icons.motorcycle,
            label: '3 wheeler',
            isSelected: controller.selectedVehicle.value == '3 wheeler',
            onTap: () => controller.selectVehicle('3 wheeler'),
          ),
          _buildSelectableOption(
            icon: Icons.local_shipping,
            label: 'Truck',
            isSelected: controller.selectedVehicle.value == 'Truck',
            onTap: () => controller.selectVehicle('Truck'),
          ),
          _buildSelectableOption(
            icon: Icons.airport_shuttle,
            label: 'Tempo',
            isSelected: controller.selectedVehicle.value == 'Tempo',
            onTap: () => controller.selectVehicle('Tempo'),
          ),
          _buildSelectableOption(
            icon: Icons.fire_truck,
            label: 'Heavy Truck',
            isSelected: controller.selectedVehicle.value == 'Heavy Truck',
            onTap: () => controller.selectVehicle('Heavy Truck'),
          ),
        ],
      ),
    );
  }

  // Widget _buildMultipleLabourOptions() {
  //   return Obx(
  //     () => Column(
  //       children: [
  //         _buildCheckboxOption(
  //       label: 'No Required Labour',
  //       isSelected: controller.selectedLabourOptions.contains('No Required'),
  //       onChanged: (value) => controller.toggleLabourOption('No Required'),
  //         ),
  //         _buildCheckboxOption(
  //           label: 'Loading Labour at Pickup',
  //           isSelected: controller.selectedLabourOptions.contains(
  //             'Pickup Labour',
  //           ),
  //           onChanged:
  //               (value) => controller.toggleLabourOption('Pickup Labour'),
  //         ),
  //         _buildCheckboxOption(
  //           label: 'Unloading Labour at Delivery',
  //           isSelected: controller.selectedLabourOptions.contains(
  //             'Delivery Labour',
  //           ),
  //           onChanged:
  //               (value) => controller.toggleLabourOption('Delivery Labour'),
  //         ),
  //         _buildCheckboxOption(
  //           label: 'Packing Services',
  //           isSelected: controller.selectedLabourOptions.contains('Packing'),
  //           onChanged: (value) => controller.toggleLabourOption('Packing'),
  //         ),
  //         _buildCheckboxOption(
  //           label: 'Unpacking Services',
  //           isSelected: controller.selectedLabourOptions.contains('Unpacking'),
  //           onChanged: (value) => controller.toggleLabourOption('Unpacking'),
  //         ),
  //         _buildCheckboxOption(
  //           label: 'Assembly Services',
  //           isSelected: controller.selectedLabourOptions.contains('Assembly'),
  //           onChanged: (value) => controller.toggleLabourOption('Assembly'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLabourInputField(String label, TextEditingController inputController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: inputController,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              hintText: 'Enter 1 to 5',
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                int val = int.tryParse(value) ?? 0;
                if (val < 1 || val > 5) {
                  inputController.clear();
                  Get.snackbar('Invalid Input', 'Please enter a number between 1 and 5');
                } else {
                controller.updatePickupLabour(value);
                }
              }
            },
          ),
        ],
      ),
    );
  }



  Widget _buildSelectableOption({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: isSelected ? AppColors.primary : AppColors.error,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption({
    required String label,
    required bool isSelected,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingOption() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.mail_outline_rounded, size: 26),
              const SizedBox(width: 10),
              const Text(
                "Delivery Type",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Obx(
            () => Row(
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: "Parcel",
                      groupValue: controller.selectedOption.value,
                      onChanged: (value) {
                        controller.selectedOption.value = value!;
                      },
                    ),
                    const Text("Parcel"),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: "Letter",
                      groupValue: controller.selectedOption.value,
                      onChanged: (value) {
                        controller.selectedOption.value = value!;
                      },
                    ),
                    const Text("Letter"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Letters up to 2kg that are not traceable. Delivery to mailbox in 5 days or next business day.",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(
                  () => CustomButton(
                    onPressed: () {},
                    text:
                        controller.weight.value <= 2
                            ? 'Price: ₹${controller.basePrice.toStringAsFixed(2)}'
                            : 'Price: ₹${controller.price.value.toStringAsFixed(2)}',
                    color: AppColors.primary,
                    textColor: AppColors.background,
                    width: 100,
                    height: 42,
                    isDisabled: false,
                    isOutlined: false,
                    hasShadow: true,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Obx(
                () => GestureDetector(
                  onTap: controller.toggleWeightSelection,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      controller.isVisible.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Obx(() {
            if (!controller.isVisible.value) return SizedBox();
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Select Weight Range',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Text(
                      'Weight: ${controller.weight.value.toStringAsFixed(1)} kg',
                    ),
                  ),
                  Obx(
                    () => Slider(
                      value: controller.weight.value,
                      min: 2,
                      max: 100,
                      divisions: 33,
                      label: '${controller.weight.value.toStringAsFixed(1)} kg',
                      onChanged: (value) => controller.onWeightChanged(value),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
