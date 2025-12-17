import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/notification_widgets/notification_section.dart';
import '../../models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample notifications data
  List<NotificationModel> todayNotifications = [
    NotificationModel(
      id: '1',
      title: 'New Appointment Booked',
      message: 'New appointment has been booked by a patient.',
      time: '1h',
      type: NotificationType.success,
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: 'Appointment Cancelled',
      message: 'Patient has cancelled their appointment.',
      time: '2h',
      type: NotificationType.cancelled,
      isRead: false,
    ),
    NotificationModel(
      id: '3',
      title: 'Appointment Rescheduled',
      message: 'Patient has rescheduled their appointment.',
      time: '8h',
      type: NotificationType.changed,
      isRead: false,
    ),
  ];

  List<NotificationModel> yesterdayNotifications = [
    NotificationModel(
      id: '4',
      title: 'New Appointment Booked',
      message: 'New appointment has been booked by a patient.',
      time: '1d',
      type: NotificationType.success,
      isRead: false,
    ),
    NotificationModel(
      id: '5',
      title: 'New Appointment Booked',
      message: 'New appointment has been booked by a patient.',
      time: '1d',
      type: NotificationType.success,
      isRead: false,
    ),
    NotificationModel(
      id: '6',
      title: 'New Appointment Booked',
      message: 'New appointment has been booked by a patient.',
      time: '1d',
      type: NotificationType.success,
      isRead: false,
    ),
    NotificationModel(
      id: '7',
      title: 'New Appointment Booked',
      message: 'New appointment has been booked by a patient.',
      time: '1d',
      type: NotificationType.success,
      isRead: false,
    ),
    NotificationModel(
      id: '8',
      title: 'New Appointment Booked',
      message: 'New appointment has been booked by a patient.',
      time: '1d',
      type: NotificationType.success,
      isRead: false,
    ),
  ];

  void _markAllAsRead(String section) {
    setState(() {
      if (section == 'today') {
        for (var notification in todayNotifications) {
          notification.isRead = true;
        }
      } else if (section == 'yesterday') {
        for (var notification in yesterdayNotifications) {
          notification.isRead = true;
        }
      }
    });
  }

  void _markAsRead(String id) {
    setState(() {
      final allNotifications = [
        ...todayNotifications,
        ...yesterdayNotifications,
      ];
      final notification = allNotifications.firstWhere((n) => n.id == id);
      notification.isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                // Today Section
                NotificationSection(
                  title: 'Today',
                  notifications: todayNotifications,
                  onMarkAllAsRead: () => _markAllAsRead('today'),
                  onNotificationTap: _markAsRead,
                ),

                SizedBox(height: 24.h),

                // Yesterday Section
                NotificationSection(
                  title: 'YESTERDAY',
                  notifications: yesterdayNotifications,
                  onMarkAllAsRead: () => _markAllAsRead('yesterday'),
                  onNotificationTap: _markAsRead,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
