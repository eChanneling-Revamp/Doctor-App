import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'appointment_tab.dart';

class AppointmentTabBar extends StatelessWidget {
  final int currentTabIndex;
  final Function(int) onTabChanged;

  const AppointmentTabBar({
    super.key,
    required this.currentTabIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.h),
      child: Row(
        children: [
          AppointmentTab(
            title: 'Current',
            index: 0,
            count: null,
            isSelected: currentTabIndex == 0,
            onTap: () => onTabChanged(0),
          ),
          SizedBox(width: 16.w),
          AppointmentTab(
            title: 'Upcoming',
            index: 1,
            count: 3,
            isSelected: currentTabIndex == 1,
            onTap: () => onTabChanged(1),
          ),
          SizedBox(width: 16.w),
          AppointmentTab(
            title: 'Past',
            index: 2,
            count: 8,
            isSelected: currentTabIndex == 2,
            onTap: () => onTabChanged(2),
          ),
        ],
      ),
    );
  }
}
