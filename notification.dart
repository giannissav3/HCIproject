import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      type: NotificationType.friendRequest,
      message: "Bob sent you a friend request",
    ),
    NotificationItem(
      type: NotificationType.like,
      message: "Alice rated your photo",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return _buildNotificationItem(notifications[index]);
        },
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    IconData iconData;
    Color iconColor;

    switch (notification.type) {
      case NotificationType.friendRequest:
        iconData = Icons.person_add;
        iconColor = Colors.blue;
        break;
      case NotificationType.like:
        iconData = Icons.thumb_up;
        iconColor = Colors.green;
        break;
    }

    return ListTile(
      leading: Icon(
        iconData,
        color: iconColor,
      ),
      title: Text(notification.message),
    );
  }
}

enum NotificationType {
  friendRequest,
  like,
}

class NotificationItem {
  final NotificationType type;
  final String message;

  NotificationItem({
    required this.type,
    required this.message,
  });
}
