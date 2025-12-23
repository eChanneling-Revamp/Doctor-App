import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/profile_widgets/profile_card.dart';
import '../../widgets/profile_widgets/settings_section.dart';
import '../../widgets/profile_widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // Profile Card
              const ProfileCard(
                name: 'Daniel Martinez',
                specialty: 'Cardiologist',
                hospital: 'Colombo General Hospital',
              ),

              SizedBox(height: 24.h),

              // Settings Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: const SettingsSection(),
              ),

              SizedBox(height: 32.h),

              // Logout Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: const LogoutButton(),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
