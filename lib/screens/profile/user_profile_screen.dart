import 'package:abhivridhiapp/screens/profile/widgets/profile_widgets.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_color.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double profileImageSize = 120; // Adjust size as needed

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Card Container
            Positioned(
              top:
                  MediaQuery.of(context).size.height * 0.10, // Adjust as needed
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                padding: EdgeInsets.only(
                  top: profileImageSize / 2,
                ), // Space for profile image
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: SingleChildScrollView(child: ProfileWidgets()),
              ),
            ),

            // Profile Image (Half inside the card, half outside)
            Positioned(
              top:
                  MediaQuery.of(context).size.height * 0.10 -
                  (profileImageSize / 2),
              child: CircleAvatar(
                radius: profileImageSize / 2,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: (profileImageSize / 2) - 5, // Inner image
                  backgroundImage: AssetImage(
                    "assets/images/profile.png",
                  ), // Your profile image
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
