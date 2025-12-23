import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'edit_session_widgets.dart';

class ActiveSessionItem extends StatelessWidget {
  final String hospitalName;
  final String patientCount;
  final String date;
  final String time;
  final String sessionType;
  final String? note;
  final Color iconColor;
  final ValueChanged<Map<String, dynamic>>? onUpdate;

  const ActiveSessionItem({
    super.key,
    required this.hospitalName,
    required this.patientCount,
    required this.date,
    required this.time,
    required this.sessionType,
    this.note,
    required this.iconColor,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE9ECEF), width: 1),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 52.w,
            height: 52.h,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              hospitalName.contains('Online') ? Icons.videocam : Icons.domain,
              color: iconColor,
              size: 26.r,
            ),
          ),
          SizedBox(width: 10.w),
          // Session info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospitalName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  patientCount,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.r,
                      color: const Color(0xFF6B7280),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  // Prefer note (more specific) when available, otherwise fall back to sessionType
                  note ?? sessionType,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          // Action buttons
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  onPressed: () async {
                    final result = await showDialog<Map<String, dynamic>>(
                      context: context,
                      builder: (context) => EditSessionModal(
                        hospitalName: hospitalName,
                        patientCount: patientCount,
                        time: time,
                        sessionType: sessionType,
                        note: note ?? sessionType,
                        date: date,
                      ),
                    );
                    if (result != null) {
                      onUpdate?.call(result);
                    }
                  },
                  icon: Icon(
                    Icons.edit_outlined,
                    color: const Color(0xFF3B82F6),
                    size: 18.r,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_outline,
                    color: const Color(0xFFEF4444),
                    size: 18.r,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
