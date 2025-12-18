import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PHRButton extends StatelessWidget {
  final VoidCallback onTap;
  const PHRButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        backgroundColor: Colors.white.withOpacity(0.9),
        foregroundColor: Colors.black87,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      icon: const Icon(Icons.assignment_ind_outlined),
      label: const Text('PHR'),
    );
  }
}
