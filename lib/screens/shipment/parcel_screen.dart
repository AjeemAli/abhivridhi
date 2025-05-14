import 'package:abhivridhiapp/screens/dashboard/dashboard_screen.dart';
import 'package:abhivridhiapp/screens/shipment/sender_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/add_shippment_controller.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

// class ParcelScreen extends StatefulWidget {
//   const ParcelScreen({super.key});
//
//   @override
//   State<ParcelScreen> createState() => _ParcelScreenState();
// }
//
// class _ParcelScreenState extends State<ParcelScreen> {
//   final AddShipmentController controller = Get.find<AddShipmentController>();
//   final isLoading = false.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(title: const Text('Add Shipment'), centerTitle: true),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             spacing: 14,
//             children: [
//               // Shipping From
//               Text(
//                 'Location',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                   color: AppColors.text,
//                 ),
//               ),
//               CustomTextField(
//                 controller: controller.textControllers[AddShipmentController.fromIndex],
//                 label: 'Location',
//                 hint: 'Enter starting location',
//                 fontWeight: FontWeight.normal,
//                 prefixIcon: Icons.location_on,
//                 obscureText: false,
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.next,
//                 enabled: true,
//                 maxLines: 1,
//                 onSubmitted: (value) {  },
//               ),
//
//               Text(
//                 'Package weight',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                   color: AppColors.text,
//                 ),
//               ),
//               // Shipping To
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.secondary),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   '${controller.weight.value.toStringAsFixed(1)} kg',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.text,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Delivery Options',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: AppColors.text,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               // Shipping Option (up to 2 kg)
//               Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.secondary),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Row(
//                       spacing: 20,
//                       children: [
//                         Text(
//                           "Delivery to Home",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "Next Day Delivery (Monday to Saturday)",
//                       textAlign: TextAlign.start,
//                       maxLines: 3,
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Obx(
//                           () => CustomButton(
//                             onPressed: () {
//                               controller.toggleNextDayDelivery();
//                             },
//                             width: 120,
//                             borderRadius: 30,
//                             height: 42,
//                             text:
//                                 controller.isNextDayDelivery.value
//                                     ? '-₹50'
//                                     : '+₹50',
//                             color:
//                                 controller.isNextDayDelivery.value
//                                     ? AppColors.secondary
//                                     : AppColors.primary,
//                             textColor: AppColors.background,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             isDisabled: false,
//                             hasShadow: false,
//                             isOutlined: true,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: AppColors.text,
//                   border: Border.all(color: AppColors.secondary),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Text(
//                       "Delivered to service point",
//                       style: TextStyle(
//                         color: AppColors.textDark,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "Next Day Delivery (Monday to Saturday)",
//                       textAlign: TextAlign.start,
//                       maxLines: 3,
//                       style: TextStyle(
//                         color: AppColors.textDark,
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Additional Services
//               Text(
//                 "Additional Services",
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: AppColors.text,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               // Order Tracking
//               Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.background,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.secondary),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Row(
//                       spacing: 20,
//                       children: [
//                         Text(
//                           "Order Tracking",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: AppColors.text,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "We will pick up your parcel within 2 business days. We do not pick up parcels in a locked apartment/house. The price only pick-up for 1 parcel.",
//                       textAlign: TextAlign.start,
//                       maxLines: 5,
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.secondary,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Obx(
//                           () => CustomButton(
//                             onPressed: () {
//                               controller.toggleOrderTracking();
//                             },
//                             width: 120,
//                             borderRadius: 30,
//                             height: 42,
//                             text:
//                                 controller.isOrderTracking.value
//                                     ? '-₹30'
//                                     : '+₹30',
//                             color:
//                                 controller.isOrderTracking.value
//                                     ? AppColors.secondary
//                                     : AppColors.primary,
//                             textColor: AppColors.background,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             isDisabled: false,
//                             hasShadow: false,
//                             isOutlined: true,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Oversize Package
//               Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.background,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.secondary),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Row(
//                       spacing: 20,
//                       children: [
//                         Text(
//                           "Oversize - max 200 cm",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: AppColors.text,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "Extra length up to 150 cm, if the length of the package exceeds 120 cm.",
//                       textAlign: TextAlign.start,
//                       maxLines: 5,
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.secondary,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Obx(
//                           () => CustomButton(
//                             onPressed: () {
//                               controller.toggleOversize();
//                             },
//                             width: 120,
//                             borderRadius: 30,
//                             height: 42,
//                             text: controller.isOversize.value ? '-₹50' : '+₹50',
//                             color:
//                                 controller.isOversize.value
//                                     ? AppColors.secondary
//                                     : AppColors.primary,
//                             textColor: AppColors.background,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             isDisabled: false,
//                             hasShadow: false,
//                             isOutlined: true,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 spacing: 10,
//                 children: [
//                   Text(
//                     "Shipping instructions",
//                     style: TextStyle(
//                       color: AppColors.text,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "Write the porto code on your letter (or print it and attach it). Post it at a postbox or a service point. It will be delivered to the recipients mailbox",
//                     textAlign: TextAlign.start,
//                     maxLines: 3,
//                     style: TextStyle(
//                       color: AppColors.secondary,
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 spacing: 10,
//                 children: [
//                   Text(
//                     "About",
//                     style: TextStyle(
//                       color: AppColors.text,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     spacing: 10,
//                     children: [
//                       Icon(Icons.info_outline, color: AppColors.error),
//
//                       Text(
//                         "Allowed letter sizes",
//                         textAlign: TextAlign.start,
//                         maxLines: 3,
//                         style: TextStyle(
//                           color: AppColors.secondary,
//                           fontSize: 13,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//
//               // Continue Button
//               Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.background,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Obx(() {
//                       return CustomButton(
//                         onPressed: () {
//
//                             if (controller.hasAdditionalServices()) {
//                               Get.to(() => SenderScreen());
//                             }
//
//                         },
//                         width: double.infinity,
//                         borderRadius: 30,
//                         height: 48,
//                         text:
//                             'Continue ₹${controller.price.value.toStringAsFixed(2)}',
//                         textColor: AppColors.text,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         isDisabled: false,
//                         hasShadow: false,
//                         isOutlined: false,
//                         color: AppColors.btnColor,
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ParcelScreen extends StatefulWidget {
  const ParcelScreen({super.key});

  @override
  State<ParcelScreen> createState() => _ParcelScreenState();
}

class _ParcelScreenState extends State<ParcelScreen> {
  final AddShipmentController controller = Get.find<AddShipmentController>();
  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Shipment Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Card
                  _buildSummaryCard(),
                  const SizedBox(height: 20),

                  // Delivery Options Section
                  _buildSectionHeader('Delivery Options'),
                  const SizedBox(height: 10),
                  _buildDeliveryOptionCard(
                    title: "Home Delivery",
                    description: "Next Day Delivery (Monday to Saturday)",
                    price: 50,
                    isSelected: controller.isNextDayDelivery.value,
                    onToggle: () => controller.toggleNextDayDelivery(),
                    icon: Icons.home,
                  ),
                  const SizedBox(height: 10),
                  _buildDeliveryOptionCard(
                    title: "Service Point Delivery",
                    description: "Standard 2-3 business days delivery",
                    price: 0,
                    isSelected: !controller.isNextDayDelivery.value,
                    onToggle: () {
                      if (controller.isNextDayDelivery.value) {
                        controller.toggleNextDayDelivery();
                      }
                    },
                    icon: Icons.store,
                    isFree: true,
                  ),
                  const SizedBox(height: 20),

                  // Additional Services Section
                  _buildSectionHeader('Additional Services'),
                  const SizedBox(height: 10),
                  _buildServiceCard(
                    title: "Order Tracking",
                    description: "Real-time tracking with notifications",
                    price: 30,
                    isSelected: controller.isOrderTracking.value,
                    onToggle: () => controller.toggleOrderTracking(),
                    icon: Icons.track_changes,
                  ),
                  const SizedBox(height: 10),
                  _buildServiceCard(
                    title: "Oversize Package",
                    description: "For packages up to 200 cm in length",
                    price: 50,
                    isSelected: controller.isOversize.value,
                    onToggle: () => controller.toggleOversize(),
                    icon: Icons.aspect_ratio,
                  ),
                  const SizedBox(height: 10),
                  _buildServiceCard(
                    title: "Fragile Handling",
                    description: "Special care for delicate items",
                    price: 40,
                    isSelected: controller.isFragileHandling.value,
                    onToggle: () => controller.toggleFragileHandling(),
                    icon: Icons.breakfast_dining,
                  ),
                  const SizedBox(height: 10),
                  _buildServiceCard(
                    title: "Same Day Delivery",
                    description: "Delivery within 4 hours (within city limits)",
                    price: 100,
                    isSelected: controller.isSameDayDelivery.value,
                    onToggle: () => controller.toggleSameDayDelivery(),
                    icon: Icons.flash_on,
                  ),
                  const SizedBox(height: 10),
                  _buildServiceCard(
                    title: "Cash on Delivery",
                    description: "Collect payment upon delivery",
                    price: 20,
                    isSelected: controller.isCashOnDelivery.value,
                    onToggle: () => controller.toggleCashOnDelivery(),
                    icon: Icons.money,
                  ),
                  const SizedBox(height: 20),

                  // Information Section
                  _buildSectionHeader('Important Information'),
                  _buildInfoItem(
                    icon: Icons.info_outline,
                    text:
                        "Allowed package sizes: Max 200 cm length, 50 kg weight",
                  ),
                  _buildInfoItem(
                    icon: Icons.warning_amber,
                    text: "Prohibited items: Flammables, weapons, perishables",
                  ),
                ],
              ),
            ),
          ),

          // Continue Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Obx(() {
              final totalPrice = controller.price.value;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      Text(
                        '₹${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () =>
                        controller.isLoading.value
                            ? SizedBox(
                              width: 50,
                              height: 50,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                            : CustomButton(
                              onPressed: () {
                                controller.addShipping();
                              },
                              width: double.infinity,
                              borderRadius: 8,
                              height: 48,
                              text: 'Checkout',
                              textColor: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              isDisabled: false,
                              hasShadow: true,
                              isOutlined: false,
                              color: AppColors.primary,
                            ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipment Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 12),

            _buildSummaryRow(
              'From',
              controller.textControllers[AddShipmentController.fromIndex].text,
              Icons.location_on,
            ),

            const SizedBox(height: 8),
            _buildSummaryRow(
              'To',
              controller.textControllers[AddShipmentController.toIndex].text,
              Icons.location_on,
            ),
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Weight',
              '${controller.weight.value.toStringAsFixed(1)} kg',
              Icons.line_weight,
            ),
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Base Price',
              '₹${controller.basePrice.toStringAsFixed(2)}',
              Icons.attach_money,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.secondary),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow:
                TextOverflow
                    .ellipsis, // Optionally add this to avoid text overflow
            style: TextStyle(fontSize: 14, color: AppColors.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
    );
  }

  Widget _buildDeliveryOptionCard({
    required String title,
    required String description,
    required int price,
    required bool isSelected,
    required VoidCallback onToggle,
    required IconData icon,
    bool isFree = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppColors.primary : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 24, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const Spacer(),
                  if (!isFree)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primary.withOpacity(0.2)
                                : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isSelected ? '-₹$price' : '+₹$price',
                        style: TextStyle(
                          color: isSelected ? AppColors.primary : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (isFree)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'FREE',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Text(
                  description,
                  style: TextStyle(fontSize: 13, color: AppColors.secondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required int price,
    required bool isSelected,
    required VoidCallback onToggle,
    required IconData icon,
  }) {
    return Obx(() {
      // Wrap with Obx to react to state changes
      final isSelected = controller.isServiceSelected(title);
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primary.withOpacity(0.2)
                                : Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        size: 20,
                        color: isSelected ? AppColors.primary : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              isSelected ? AppColors.primary : AppColors.text,
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.2,
                      child: Switch(
                        value: isSelected,
                        onChanged: (value) => onToggle(),
                        activeColor: AppColors.primary,
                        activeTrackColor: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 52),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              isSelected
                                  ? AppColors.primary
                                  : AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isSelected ? '-₹$price' : '+₹$price',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? AppColors.primary : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInfoItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.secondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
