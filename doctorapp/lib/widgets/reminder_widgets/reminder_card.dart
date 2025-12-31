import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/reminder.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onToggle,
  });

  final Reminder reminder;
  final ValueChanged<bool> onToggle;

  IconData _iconForCategory(String category) {
    switch (category) {
      case 'Medicine Reminder':
        return Icons.medication;
      case 'Appointment Reminder':
        return Icons.calendar_today;
      case 'Follow-up Reminder':
        return Icons.local_hospital;
      case 'Lab/Test Reminder':
        return Icons.science;
      case 'Health Routine Reminder':
        return Icons.self_improvement;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        leading: CircleAvatar(
          radius: 22.r,
          backgroundColor: const Color(0xFF4A3FFF).withOpacity(0.12),
          child: Icon(
            _iconForCategory(reminder.category),
            color: const Color(0xFF4A3FFF),
            size: 22.r,
          ),
        ),
        title: Text(
          reminder.title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Text(
              '${reminder.time.format(context)} · ${reminder.repeat}',
              style: TextStyle(fontSize: 13.sp, color: Colors.black54),
            ),
            if (reminder.description != null) ...[
              SizedBox(height: 6.h),
              Text(
                reminder.description!,
                style: TextStyle(fontSize: 13.sp, color: Colors.black45),
              ),
            ],
          ],
        ),
        trailing: Switch(
          value: reminder.enabled,
          activeThumbColor: const Color(0xFF4A3FFF),
          onChanged: onToggle,
        ),
      ),
    );
  }
}
