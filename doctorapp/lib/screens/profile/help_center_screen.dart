import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/profile_widgets/support_contact_list.dart';
import '../../widgets/profile_widgets/system_status_card.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help Center',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Get help and support',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Support Contact List
                const SupportContactList(),

                SizedBox(height: 24.h),

                // System Status Card
                const SystemStatusCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
