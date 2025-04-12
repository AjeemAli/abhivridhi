import 'package:abhivridhiapp/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../core/services/support_controller.dart';

class SupportScreen extends StatelessWidget {
  final SupportController supportController = Get.put(SupportController());
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Support Details'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/image_10.png',
              fit: BoxFit.fill,
              height: 250,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(height: 20),

            // Chat Section
            _buildSectionHeader('Chat with Us'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Send message here...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      maxLines: 3,
                      minLines: 1,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      // Handle send message
                      if (_messageController.text.isNotEmpty) {
                        // Implement send functionality
                        Get.snackbar('Message Sent', 'We will respond soon');
                        _messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Opening Hours Section
            _buildSectionHeader('Opening Hours'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Business Days ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Text(' 9:00 AM - 6:00 PM'),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Previous Support Tickets
            _buildSectionHeader('Contact Us'),
            const SizedBox(height: 10),
            Obx(() {
              if (supportController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (supportController.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(supportController.errorMessage.value),
                );
              } else if (supportController.supportList.isEmpty) {
                return const Center(child: Text('No support tickets found.'));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: supportController.supportList.length,
                  itemBuilder: (context, index) {
                    final detail = supportController.supportList[index];
                    return Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.call_outlined,
                                    color: AppColors.error,
                                  ),

                                  Text("Phone:"),
                                ],
                              ),
                              Text("${detail.contactNo}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    color: AppColors.error,
                                  ),

                                  Text("Email:"),
                                ],
                              ),
                              Text("${detail.email}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.mail_outline_rounded,
                                    color: AppColors.error,
                                  ),

                                  Text("Message:"),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  "${detail.messages}",
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // child: ListTile(
                      //   contentPadding: const EdgeInsets.all(16),
                      //   title: Text(
                      //     detail.email ?? 'No Email',
                      //     style: const TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   subtitle: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       const SizedBox(height: 8),
                      //       Row(
                      //         children: [
                      //           Icon(Icons.call_outlined,color: AppColors.error,),
                      //           Text("Phone:"),
                      //           Text(detail.contactNo ?? 'N/A'),
                      //         ],
                      //       ),
                      //       const SizedBox(height: 4),
                      //       Text("Message: ${detail.messages ?? ''}"),
                      //       const SizedBox(height: 4),
                      //       Text(
                      //         "Updated: ${detail.updatedAt ?? ''}",
                      //         style: TextStyle(
                      //           color: Colors.grey[600],
                      //           fontSize: 12,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //
                      // ),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
    );
  }
}
