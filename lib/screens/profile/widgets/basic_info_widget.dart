import 'package:flutter/material.dart';

import '../../../core/utils/app_color.dart';
import 'package:get/get.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({super.key});

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
              onTap: () => _navigateToScreen(context, '/account'),
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () => _navigateToScreen(context, '/change_password'),
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.payments_outlined,
              title: 'Billing/Payment',
              onTap: () => _navigateToScreen(context, '/payment'),
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.check_box_outlined,
              title: 'Track Shipments',
              onTap: () => _navigateToScreen(context, '/shipments'),
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.logout,
              title: 'Logout',
              iconColor: Colors.red,
              textStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              onTap: () => _navigateToScreen(context, '/logout'),
            ),
          ],
        ),
      ),
    );
  }
}


