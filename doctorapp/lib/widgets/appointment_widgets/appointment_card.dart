import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String type;
  final String time;
  final bool isConfirmed;
  final String initials;
  final VoidCallback? onTap;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.type,
    required this.time,
    required this.isConfirmed,
    required this.initials,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 24.r,
              backgroundColor: Colors.grey.shade300,
              child: Text(
                initials,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Patient info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    type,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16.r,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Status
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isConfirmed
                    ? Colors.green.shade100
                    : Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                isConfirmed ? 'Confirmed' : 'Pending',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isConfirmed
                      ? Colors.green.shade700
                      : Colors.orange.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
