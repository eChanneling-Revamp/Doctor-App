import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentTab extends StatelessWidget {
  final String title;
  final int index;
  final int? count;
  final bool isSelected;
  final VoidCallback onTap;

  const AppointmentTab({
    super.key,
    required this.title,
    required this.index,
    this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color(0xFF4C40F7)
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? const Color(0xFF4C40F7)
                        : Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (count != null) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C40F7),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
