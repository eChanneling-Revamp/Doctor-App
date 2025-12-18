import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkingDaysWidget extends StatelessWidget {
  final Map<String, bool> workingDays;
  final void Function(String day, bool value) onToggle;

  const WorkingDaysWidget({
    super.key,
    required this.workingDays,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Working Days',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        ...workingDays.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 2.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: entry.value ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8.r,
                    child: Switch(
                      value: entry.value,
                      onChanged: (bool value) => onToggle(entry.key, value),
                      activeColor: const Color(0xFF4CAF50),
                      inactiveThumbColor: Colors.grey.shade400,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
