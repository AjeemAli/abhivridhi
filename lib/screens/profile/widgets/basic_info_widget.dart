import 'package:abhivridhiapp/screens/profile/change_password_sreen.dart';
import 'package:flutter/material.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/utils/app_color.dart';
import 'package:get/get.dart';

import '../billing_history_screen.dart';
import '../edit_profile_screen.dart';

class BasicInfoWidget extends StatelessWidget {
   BasicInfoWidget({super.key});
final logout=   Get.put(AuthController());
  void _navigateToScreen(BuildContext context, String route) {
    Get.toNamed(route);
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    TextStyle? textStyle,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.primary),
      title: Text(title, style: textStyle ?? const TextStyle(fontSize: 13,fontWeight: FontWeight.normal)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            _buildListTile(
              icon: Icons.account_circle,
              title: 'Account',
              onTap: () => Get.to(()=> EditProfileScreen()),
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () => Get.to(()=> ChangePasswordScreen()),
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.payments_outlined,
              title: 'Billing/Payment',
              onTap: () => Get.to(()=> BillingHistoryScreen()),
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.check_box_outlined,
              title: 'Track Shipments',
              onTap: () => Get.to(()=> BillingHistoryScreen()),
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.logout,
              title: 'Logout',
              iconColor: Colors.red,
              textStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              onTap: () {
                final authController = Get.find<AuthController>();
                authController.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}


