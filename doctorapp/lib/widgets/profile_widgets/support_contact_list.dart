import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/snackbar_utils.dart';

class SupportContactItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SupportContactItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: iconColor, size: 24.r),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 24.r),
          ],
        ),
      ),
    );
  }
}

class SupportContactList extends StatelessWidget {
  const SupportContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Support',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),

        // Phone Support
        SupportContactItem(
          icon: Icons.phone_outlined,
          iconColor: const Color(0xFF4C40F7),
          iconBgColor: const Color(0xFFEDE9FE),
          title: 'Phone Support',
          subtitle: '123456789+',
          onTap: () {
            SnackbarUtils.info(context, 'Opening phone dialer...');
          },
        ),

        SizedBox(height: 12.h),

        // Email Support
        SupportContactItem(
          icon: Icons.email_outlined,
          iconColor: const Color(0xFF4C40F7),
          iconBgColor: const Color(0xFFEDE9FE),
          title: 'Email Support',
          subtitle: '123456789+',
          onTap: () {
            SnackbarUtils.info(context, 'Opening email client...');
          },
        ),

        SizedBox(height: 12.h),

        // WhatsApp Support
        SupportContactItem(
          icon: Icons.chat_outlined,
          iconColor: const Color(0xFF4C40F7),
          iconBgColor: const Color(0xFFEDE9FE),
          title: 'Whats app Support',
          subtitle: '123456789+',
          onTap: () {
            SnackbarUtils.info(context, 'Opening WhatsApp...');
          },
        ),
      ],
    );
  }
}
