import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentItem extends StatelessWidget {
  final String hospitalName;
  final String consultationType;
  final String time;
  final String amount;
  final bool isPaid;

  const PaymentItem({
    super.key,
    required this.hospitalName,
    required this.consultationType,
    required this.time,
    required this.amount,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Left side - Hospital info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospitalName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  consultationType,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Right side - Amount and status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isPaid ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  isPaid ? 'Paid' : 'Pending',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isPaid ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
