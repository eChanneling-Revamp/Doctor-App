import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleEditHeader extends StatelessWidget {
  final String title;

  const ScheduleEditHeader({super.key, this.title = 'Schedule Edit'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Schedule Edit',
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}
