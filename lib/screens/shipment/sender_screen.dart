import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/add_shippment_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SenderScreen extends StatefulWidget {
  @override
  _SenderScreenState createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final AddShipmentController controller = Get.find<AddShipmentController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 46,
          child: CustomTextField(
            controller: controller,
            label: label,
            hint: hint,
            fontWeight: FontWeight.normal,
            obscureText: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            enabled: true,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Sender Information'),
        centerTitle: true,
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: const [Tab(text: "Private"), Tab(text: "Company")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSenderForm(isCompany: false),
          _buildSenderForm(isCompany: true),
        ],
      ),
    );
  }

  Widget _buildSenderForm({required bool isCompany}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          buildTextField(
            label: isCompany ? 'Company Name' : 'Full Name',
            hint: isCompany ? 'Enter company name' : 'Enter your name',
            controller:
                controller.textControllers[AddShipmentController.nameIndex],
          ),
          buildTextField(
            label: 'Address',
            hint: 'Enter your address',
            controller:
                controller.textControllers[AddShipmentController.toIndex],
          ),
          buildTextField(
            label: 'Zip Code',
            hint: 'Enter zip code',
            controller: controller.zipController,
            keyboardType: TextInputType.number,
          ),
          buildTextField(
            label: 'Location',
            hint: 'Enter location',
            controller:
                controller.textControllers[AddShipmentController.fromIndex],
            prefixIcon: Icons.location_on,
          ),
          buildTextField(
            label: 'Phone',
            hint: 'Enter phone number',
            controller:
                controller.textControllers[AddShipmentController.phoneIndex],
            keyboardType: TextInputType.phone,
          ),
          buildTextField(
            label: 'Email',
            hint: 'Enter email',
            controller:
                controller.textControllers[AddShipmentController.emailIndex],
            keyboardType: TextInputType.emailAddress,
          ),
          if (isCompany)
            buildTextField(
              label: 'GST Number',
              hint: 'Enter GST number',
              controller:
                  controller.textControllers[AddShipmentController.gstIndex],
              keyboardType: TextInputType.text,
            ),
          Text(
            "Add At least one way for us notify the recipient",
            textAlign: TextAlign.start,
            maxLines: 3,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "If the recipient has the app we will add the parcel in their tab automatically",
            textAlign: TextAlign.start,
            maxLines: 3,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price",
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹${controller.price.value.toStringAsFixed(2)}',
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
          Obx(
            () => CustomButton(
              onPressed:
                  controller.isLoading.value
                      ? null
                      : () => controller.addShipping(),
              width: double.infinity,
              borderRadius: 30,
              height: 48,
              text:
                  controller.isLoading.value
                      ? 'Processing...'
                      : 'Add recipient',
              textColor: AppColors.text,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              isDisabled: controller.isLoading.value,
              hasShadow: false,
              isOutlined: false,
              color:
                  controller.isLoading.value ? Colors.grey : AppColors.primary,
              child:
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
