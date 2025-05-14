import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/user_controller.dart';

class AccountScreen extends StatelessWidget {
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('My Account'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Get.toNamed('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            _buildProfileHeader(),

            // Account Details Section
            _buildAccountDetailsCard(),

            // Menu Options Section
            _buildMenuOptions(),

            // Logout Button
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Obx(() => Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
        BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 5),),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue[100],
            backgroundImage: _userController.user.value.profileImage != null
                ? NetworkImage(_userController.user.value.profileImage!)
                : null,
            child: _userController.user.value.profileImage == null
                ? Icon(Icons.person, size: 40, color: Colors.blue)
                : null,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userController.user.value.name ?? 'Guest User',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  _userController.user.value.email ?? 'email@example.com',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                if (_userController.user.value.phone != null)
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(_userController.user.value.phone!),
                    ],
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: () => Get.toNamed('/edit-profile'),
          ),
        ],
      ),
    ));
  }

  Widget _buildAccountDetailsCard() {
    return Card(
      margin: EdgeInsets.all(15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildDetailRow(
              icon: Icons.assignment,
              title: 'My Orders',
              value: '12',
              onTap: () => Get.toNamed('/orders'),
            ),
            Divider(),
            _buildDetailRow(
              icon: Icons.local_shipping,
              title: 'Active Deliveries',
              value: '3',
              onTap: () => Get.toNamed('/active-deliveries'),
            ),
            Divider(),
            _buildDetailRow(
              icon: Icons.star,
              title: 'Reward Points',
              value: '1,250',
              onTap: () => Get.toNamed('/rewards'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildMenuOptions() {
    return Card(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildMenuOption(
            icon: Icons.location_on,
            title: 'Saved Addresses',
            onTap: () => Get.toNamed('/saved-addresses'),
          ),
          Divider(height: 1),
          _buildMenuOption(
            icon: Icons.payment,
            title: 'Payment Methods',
            onTap: () => Get.toNamed('/payment-methods'),
          ),
          Divider(height: 1),
          _buildMenuOption(
            icon: Icons.notifications,
            title: 'Notification Settings',
            onTap: () => Get.toNamed('/notification-settings'),
          ),
          Divider(height: 1),
          _buildMenuOption(
            icon: Icons.help,
            title: 'Help Center',
            onTap: () => Get.toNamed('/help-center'),
          ),
          Divider(height: 1),
          _buildMenuOption(
            icon: Icons.info,
            title: 'About App',
            onTap: () => Get.toNamed('/about'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: EdgeInsets.all(15),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[400],
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Logout',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          Get.defaultDialog(
            title: 'Logout',
            content: Text('Are you sure you want to logout?'),
            confirm: ElevatedButton(
              onPressed: () {
                _userController.logout();
                Get.offAllNamed('/login');
              },
              child: Text('Confirm'),
            ),
            cancel: TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
          );
        },
      ),
    );
  }
}