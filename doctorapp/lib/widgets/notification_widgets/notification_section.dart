import 'package:flutter/material.dart';
import '../../models/notification_model.dart';
import 'notification_item.dart';

class NotificationSection extends StatelessWidget {
  final String title;
  final List<NotificationModel> notifications;
  final VoidCallback onMarkAllAsRead;
  final Function(String) onNotificationTap;

  const NotificationSection({
    super.key,
    required this.title,
    required this.notifications,
    required this.onMarkAllAsRead,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              InkWell(
                onTap: onMarkAllAsRead,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    'Mark all as read',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Notification Items
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return NotificationItem(
                notification: notifications[index],
                onTap: () => onNotificationTap(notifications[index].id),
              );
            },
          ),
        ],
      ),
    );
  }
}
