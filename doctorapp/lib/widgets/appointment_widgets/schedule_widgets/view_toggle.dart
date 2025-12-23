import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewToggle extends StatelessWidget {
  final bool isDailyView;
  final ValueChanged<bool> onViewChanged;

  const ViewToggle({
    super.key,
    required this.isDailyView,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onViewChanged(false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: !isDailyView
                          ? const Color(0xFF4C40F7)
                          : Colors.transparent,
                      width: 2.r,
                    ),
                  ),
                ),
                child: Text(
                  'Week View',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: !isDailyView
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: !isDailyView
                        ? const Color(0xFF4C40F7)
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onViewChanged(true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDailyView
                          ? const Color(0xFF4C40F7)
                          : Colors.transparent,
                      width: 2.r,
                    ),
                  ),
                ),
                child: Text(
                  'Daily View',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: isDailyView ? FontWeight.w600 : FontWeight.w400,
                    color: isDailyView
                        ? const Color(0xFF4C40F7)
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
