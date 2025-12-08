import 'package:flutter/material.dart';
import '../../models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  Color _getBackgroundColor() {
    switch (notification.type) {
      case NotificationType.success:
        return const Color(0xFFE8F5E9);
      case NotificationType.cancelled:
        return const Color(0xFFFFEBEE);
      case NotificationType.changed:
        return const Color(0xFFEDE7F6);
    }
  }

  Color _getIconColor() {
    switch (notification.type) {
      case NotificationType.success:
        return const Color(0xFF4CAF50);
      case NotificationType.cancelled:
        return const Color(0xFFF44336);
      case NotificationType.changed:
        return const Color(0xFF673AB7);
    }
  }

  Color _getItemBackgroundColor() {
    if (notification.isRead) {
      return Colors.white;
    }

    switch (notification.type) {
      case NotificationType.success:
        return const Color(0xFFF1F8F4);
      case NotificationType.cancelled:
        return const Color(0xFFFFF5F5);
      case NotificationType.changed:
        return const Color(0xFFF5F3F9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _getItemBackgroundColor(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                color: _getIconColor(),
                size: 24,
              ),
            ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        notification.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
