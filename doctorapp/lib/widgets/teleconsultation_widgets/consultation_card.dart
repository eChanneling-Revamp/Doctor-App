import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsultationCard extends StatelessWidget {
  final Map<String, dynamic> consultation;
  final VoidCallback? onStart;

  const ConsultationCard({super.key, required this.consultation, this.onStart});

  @override
  Widget build(BuildContext context) {
    final bool isConfirmed = consultation['isConfirmed'] as bool;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE9ECEF), width: 1),
      ),
      child: Row(
        children: [
          // Video Icon
          Container(
            width: 52.r,
            height: 52.r,
            decoration: BoxDecoration(
              color: const Color(0xFF6D28D9).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.videocam, color: Color(0xFF6D28D9), size: 26.r),
          ),
          SizedBox(width: 10.w),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      consultation['name'] as String,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: isConfirmed
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : const Color(0xFFF59E0B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        isConfirmed ? 'Confirmed' : 'Pending',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: isConfirmed
                              ? const Color(0xFF10B981)
                              : const Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.r,
                      color: Color(0xFF6B7280),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      consultation['time'] as String,
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
                  consultation['day'] as String,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          // Action: Start icon
          if (onStart != null)
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: IconButton(
                onPressed: onStart,
                icon: Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFF10B981),
                  size: 22.r,
                ),
                padding: EdgeInsets.zero,
                tooltip: 'Start consultation',
              ),
            ),
        ],
      ),
    );
  }
}
