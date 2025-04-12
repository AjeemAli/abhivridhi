import 'package:abhivridhiapp/screens/shipment/parcel_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/add_shippment_controller.dart';
import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class AddShipmentScreen extends StatefulWidget {
  @override
  State<AddShipmentScreen> createState() => _AddShipmentScreenState();
}

class _AddShipmentScreenState extends State<AddShipmentScreen> {
  final AddShipmentController controller = Get.put(AddShipmentController());

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
            spacing: 10,
            children: [
              _buildLabel('Shipping from'),
              CustomTextField(
                controller: controller.textControllers[AddShipmentController.fromIndex],
                label: 'Location',
                hint: 'Enter starting location',
                prefixIcon: Icons.location_on,
                textInputAction: TextInputAction.next,
                obscureText: false,
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabled: true, onSubmitted: (value) {  },
              ),
              const SizedBox(height: 6),

              _buildLabel('Shipping to'),
              CustomTextField(
                controller: controller.textControllers[AddShipmentController.toIndex],
                label: 'Location',
                hint: 'Enter destination',
                prefixIcon: Icons.location_on,
                textInputAction: TextInputAction.done,
                obscureText: false,
                maxLines: 1,
                keyboardType: TextInputType.text,
                enabled: true,
                onSubmitted: (value) {  },
              ),
              const SizedBox(height: 10),

              _buildLabel('Shipping Options'),

              // ✅ FIX: Ensured only required part is wrapped in Obx()
              _buildShippingOption(),

              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  if (controller.isValidInput()) {
                    controller.printAllValues();
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
          Column(
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

              // Use Obx to make the radio buttons reactive
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
            ],
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

              // ✅ FIX: Wrapped only the icon inside Obx()
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

          // ✅ FIX: Wrapped only the part that needs updates inside Obx()
          Obx(() {
            if (!controller.isVisible.value) return SizedBox();
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Select Weight Range',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ✅ FIX: Only updating the weight text inside Obx()
                    Obx(
                      () => Text(
                        'Weight: ${controller.weight.value.toStringAsFixed(1)} kg',
                      ),
                    ),

                    // ✅ FIX: Only updating Slider inside Obx()
                    Obx(
                      () => Slider(
                        value: controller.weight.value,
                        min: 2,
                        max: 100,
                        divisions: 33,
                        label:
                            '${controller.weight.value.toStringAsFixed(1)} kg',
                        onChanged: (value) => controller.onWeightChanged(value),
                      ),
                    ),

                    // CustomButton(
                    //   onPressed: controller.onSubmit,
                    //   text: 'Select',
                    //   color: AppColors.btnColor,
                    //   textColor: AppColors.text,
                    //   width: double.infinity,
                    //   height: 42,
                    //   isDisabled: false,
                    //   isOutlined: false,
                    //   hasShadow: true,
                    // ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
