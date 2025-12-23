import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PeriodSelector extends StatelessWidget {
  final String selectedPeriod;
  final List<String> periods;
  final ValueChanged<String?> onChanged;

  const PeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.periods,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.tune, color: const Color(0xFF4318FF), size: 18.r),
        SizedBox(width: 12.w),
        SizedBox(
          width: 150.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF4318FF)),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedPeriod,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF4318FF),
                ),
                style: TextStyle(
                  color: const Color(0xFF4318FF),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                items: periods.map((String period) {
                  return DropdownMenuItem<String>(
                    value: period,
                    child: Text(period),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
