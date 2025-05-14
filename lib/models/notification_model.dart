class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String timestamp;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
  });

  // Factory constructor to create Notification from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}
