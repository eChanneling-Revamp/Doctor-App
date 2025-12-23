import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../share_widgets/buttons.dart';

class NextConsultationCard extends StatelessWidget {
  final Map<String, dynamic> consultation;
  final VoidCallback? onStart;
  final VoidCallback? onViewPHR;
  final VoidCallback? onStop;

  const NextConsultationCard({
    super.key,
    required this.consultation,
    this.onStart,
    this.onViewPHR,
    this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B4EF7), Color(0xFF7B6FF9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.double_arrow_rounded,
                    color: Colors.white,
                    size: 20.r,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Next Consultation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white, size: 16.r),
                    SizedBox(width: 4.w),
                    Text(
                      (consultation['time'] as String).split(' - ').first,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: Colors.white.withOpacity(0.2),
                backgroundImage: const AssetImage('assets/images/avatar.png'),
                onBackgroundImageError: (_, __) {},
                child: Text(
                  consultation['initials'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      consultation['name'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      consultation['time'] as String,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      consultation['day'] as String,
                      style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: onStop ?? () {},
                child: Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.stop_rounded,
                    color: Colors.white,
                    size: 18.r,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Start',
                  onPressed: onStart ?? () {},
                  backgroundColor: Colors.white,
                  textColor: const Color(0xFF5B4EF7),
                  borderColor: Colors.white,
                  height: 44.h,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomOutlinedButton(
                  text: 'View PHR',
                  onPressed: onViewPHR ?? () {},
                  borderColor: Colors.white,
                  textColor: Colors.white,
                  height: 44.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
