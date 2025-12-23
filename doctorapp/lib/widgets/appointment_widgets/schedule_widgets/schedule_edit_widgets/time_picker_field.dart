import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimePickerField extends StatelessWidget {
  final String label;
  final TimeOfDay time;
  final ValueChanged<TimeOfDay> onTimePicked;

  const TimePickerField({
    super.key,
    required this.label,
    required this.time,
    required this.onTimePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: time,
            );
            if (picked != null) onTimePicked(picked);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                time.format(context),
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
