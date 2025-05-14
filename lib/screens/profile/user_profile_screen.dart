import 'package:abhivridhiapp/screens/profile/widgets/profile_widgets.dart';
import 'package:flutter/material.dart';

import '../../core/services/profile_controller.dart';
import '../../core/utils/app_color.dart';

import 'package:get/get.dart';



class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final ProfileController controller = Get.find();

  Future<void> _refreshProfile() async {
    await controller.fetchProfile(force: true);
  }

  @override
  Widget build(BuildContext context) {
    double profileImageSize = 120;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshProfile,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(), // Important for pull to refresh
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // Card Container
                        Container(
                          padding: EdgeInsets.only(top: profileImageSize / 2 + 10),
                          margin: const EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const UserProfileBody(),
                        ),

                        // Profile Image
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.10 - (profileImageSize / 2),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: CircleAvatar(
                              radius: profileImageSize / 2 - 5,
                              backgroundImage: const AssetImage("assets/images/Logo.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

