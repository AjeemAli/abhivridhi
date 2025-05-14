import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/notification_model.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> notificationsModel;


  @override
  void initState() {
    super.initState();
    notificationsModel = loadNotifications();
  }

  // Function to load notifications from the JSON file
  Future<List<NotificationModel>> loadNotifications() async {
    try {
      final String response = await rootBundle.loadString('assets/notifications.json');
      debugPrint('Loaded JSON: $response');
      final List<dynamic> data = json.decode(response);

      if (data.isEmpty) {
        throw Exception("No data found in the JSON file.");
      }

      return data.map((item) => NotificationModel.fromJson(item)).toList();
    } catch (e) {
      debugPrint('Error loading notifications: $e');
      throw Exception("Error loading notifications: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: notificationsModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Show the error message if something went wrong
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No notifications available"));
          }

          final notificationList = snapshot.data!;

          return ListView.builder(
            itemCount: notificationList.length,
            itemBuilder: (context, index) {
              final notification = notificationList[index];
              return ListTile(
                title: Text(notification.title),
                subtitle: Text(notification.message),
                trailing: Text(notification.timestamp),
                onTap: () {
                  // Show a detailed dialog on tap
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(notification.title),
                        content: Text(notification.message),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

