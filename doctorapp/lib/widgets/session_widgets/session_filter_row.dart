import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnSessionFilterSelected = void Function(String value);

class SessionFilterRow extends StatelessWidget {
  final String selectedFilter;
  final int activeFilterCount;
  final OnSessionFilterSelected onSelected;

  const SessionFilterRow({
    super.key,
    required this.selectedFilter,
    required this.activeFilterCount,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<String>(
          onSelected: onSelected,
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'All', child: Text('All')),
            const PopupMenuItem(value: 'Hospital', child: Text('Hospital')),
            const PopupMenuItem(
              value: 'Teleconsultation',
              child: Text('Teleconsultation'),
            ),
          ],
          child: OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.filter_list, color: Color(0xFF4A3FFF)),
            label: Row(
              children: [
                const Text('Filter'),
                SizedBox(width: 6.w),
                if (activeFilterCount > 0)
                  CircleAvatar(
                    radius: 10.r,
                    backgroundColor: const Color(0xFF4A3FFF),
                    child: Text(
                      '$activeFilterCount',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
              ],
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),

        SizedBox(width: 12.w),

        Chip(
          backgroundColor: Colors.grey.shade100,
          label: Text(
            selectedFilter,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
