import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeSlotCard extends StatelessWidget {
  final String time;
  final String? patient;

  const TimeSlotCard({super.key, required this.time, this.patient});

  @override
  Widget build(BuildContext context) {
    final isBooked = patient != null;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.r, vertical: 4.h),
      decoration: BoxDecoration(
        color: isBooked ? const Color(0xFF4CAF50) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isBooked ? const Color(0xFF4CAF50) : Colors.grey.shade300,
          width: 1.5.r,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isBooked ? Colors.white : Colors.black87,
            ),
          ),
          if (isBooked) ...[
            SizedBox(height: 2.h),
            Text(
              patient!,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
