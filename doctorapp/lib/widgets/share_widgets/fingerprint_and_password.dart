import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Fingerprint Button
class FingerprintButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FingerprintButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 60.r,
            height: 60.r,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.fingerprint, size: 30.r, color: Colors.black54),
          ),
          SizedBox(height: 8.h),
          Text(
            'Use Fingerprint',
            style: TextStyle(fontSize: 14.sp, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// Password Strength Indicator
class PasswordStrengthIndicator extends StatelessWidget {
  final String label;
  final bool isValid;

  const PasswordStrengthIndicator({
    super.key,
    required this.label,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          size: 16.r,
          color: isValid ? Colors.green : Colors.grey,
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isValid ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}
