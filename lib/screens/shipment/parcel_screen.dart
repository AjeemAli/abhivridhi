import 'package:abhivridhiapp/screens/shipment/sender_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/add_shippment_controller.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

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
      appBar: AppBar(title: const Text('Add Shipment'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 14,
            children: [
              // Shipping From
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.text,
                ),
              ),
              CustomTextField(
                controller: controller.textControllers[AddShipmentController.fromIndex],
                label: 'Location',
                hint: 'Enter starting location',
                fontWeight: FontWeight.normal,
                prefixIcon: Icons.location_on,
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enabled: true,
                maxLines: 1,
              ),

              Text(
                'Package weight',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.text,
                ),
              ),
              // Shipping To
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondary),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${controller.weight.value.toStringAsFixed(1)} kg',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Delivery Options',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Shipping Option (up to 2 kg)
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondary),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Row(
                      spacing: 20,
                      children: [
                        Text(
                          "Delivery to Home",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Next Day Delivery (Monday to Saturday)",
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => CustomButton(
                            onPressed: () {
                              controller.toggleNextDayDelivery();
                            },
                            width: 120,
                            borderRadius: 30,
                            height: 42,
                            text:
                                controller.isNextDayDelivery.value
                                    ? '-₹50'
                                    : '+₹50',
                            color:
                                controller.isNextDayDelivery.value
                                    ? AppColors.secondary
                                    : AppColors.primary,
                            textColor: AppColors.background,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            isDisabled: false,
                            hasShadow: false,
                            isOutlined: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.text,
                  border: Border.all(color: AppColors.secondary),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      "Delivered to service point",
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Next Day Delivery (Monday to Saturday)",
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Additional Services
              Text(
                "Additional Services",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Order Tracking
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondary),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Row(
                      spacing: 20,
                      children: [
                        Text(
                          "Order Tracking",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "We will pick up your parcel within 2 business days. We do not pick up parcels in a locked apartment/house. The price only pick-up for 1 parcel.",
                      textAlign: TextAlign.start,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => CustomButton(
                            onPressed: () {
                              controller.toggleOrderTracking();
                            },
                            width: 120,
                            borderRadius: 30,
                            height: 42,
                            text:
                                controller.isOrderTracking.value
                                    ? '-₹30'
                                    : '+₹30',
                            color:
                                controller.isOrderTracking.value
                                    ? AppColors.secondary
                                    : AppColors.primary,
                            textColor: AppColors.background,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            isDisabled: false,
                            hasShadow: false,
                            isOutlined: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Oversize Package
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondary),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Row(
                      spacing: 20,
                      children: [
                        Text(
                          "Oversize - max 200 cm",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Extra length up to 150 cm, if the length of the package exceeds 120 cm.",
                      textAlign: TextAlign.start,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => CustomButton(
                            onPressed: () {
                              controller.toggleOversize();
                            },
                            width: 120,
                            borderRadius: 30,
                            height: 42,
                            text: controller.isOversize.value ? '-₹50' : '+₹50',
                            color:
                                controller.isOversize.value
                                    ? AppColors.secondary
                                    : AppColors.primary,
                            textColor: AppColors.background,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            isDisabled: false,
                            hasShadow: false,
                            isOutlined: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "Shipping instructions",
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Write the porto code on your letter (or print it and attach it). Post it at a postbox or a service point. It will be delivered to the recipients mailbox",
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "About",
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.info_outline, color: AppColors.error),

                      Text(
                        "Allowed letter sizes",
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Continue Button
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Obx(() {
                      return CustomButton(
                        onPressed: () {

                            if (controller.hasAdditionalServices()) {
                              Get.to(() => SenderScreen());
                            }

                        },
                        width: double.infinity,
                        borderRadius: 30,
                        height: 48,
                        text:
                            'Continue ₹${controller.price.value.toStringAsFixed(2)}',
                        textColor: AppColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        isDisabled: false,
                        hasShadow: false,
                        isOutlined: false,
                        color: AppColors.btnColor,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
