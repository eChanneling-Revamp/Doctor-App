import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionItem extends StatelessWidget {
  final String id;
  final String date;
  final String time;
  final String hospital;
  final String paymentMethod;
  final String amount;
  final String type;

  const TransactionItem({
    super.key,
    required this.id,
    required this.date,
    required this.time,
    required this.hospital,
    required this.paymentMethod,
    required this.amount,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      hospital,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      paymentMethod,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4318FF),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
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
