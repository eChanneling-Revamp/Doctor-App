import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: _getItemBackgroundColor(),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                color: _getIconColor(),
                size: 24.r,
              ),
            ),

            SizedBox(width: 12.w),

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
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        notification.time,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: 14.sp,
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
