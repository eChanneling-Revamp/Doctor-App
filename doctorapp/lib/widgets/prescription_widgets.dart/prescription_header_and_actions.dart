import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../share_widgets/buttons.dart';
import '../../utils/snackbar_utils.dart';
import '../../screens/home/patient_history_screen.dart';

class PrescriptionHeader extends StatelessWidget {
  const PrescriptionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 12.h),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(12.r),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28.r,
                      backgroundImage: const AssetImage(
                        'assets/images/logo.png',
                      ),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Mary De Silva',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Age : 28  \nID : E00210\nRef : App-2025002',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F7EB),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: const Text(
                        'Active',
                        style: TextStyle(color: Color(0xFF10B981)),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.grey.shade200),
              InkWell(
                onTap: () => PatientHistoryScreen.push(context),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 12.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history_rounded,
                        size: 16.r,
                        color: const Color(0xFF4A3FFF),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'View Patient History',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4A3FFF),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 16.r,
                        color: const Color(0xFF4A3FFF),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PrescriptionBottomActions extends StatelessWidget {
  final VoidCallback? onShare;
  final VoidCallback? onSend;

  const PrescriptionBottomActions({super.key, this.onShare, this.onSend});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Share',
            onPressed: onShare ?? () => SnackbarUtils.info(context, 'Shared'),
            backgroundColor: const Color(0xFF4A3FFF),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomOutlinedButton(
            text: 'Send to Patient',
            onPressed:
                onSend ?? () => SnackbarUtils.info(context, 'Sent to patient'),
            borderColor: Colors.grey.shade300,
            textColor: Colors.black87,
            height: 48.h,
          ),
        ),
      ],
    );
  }
}
