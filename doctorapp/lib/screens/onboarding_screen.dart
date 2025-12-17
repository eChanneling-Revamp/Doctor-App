import 'package:doctorapp/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/share_widgets/buttons.dart';
import '../widgets/share_widgets/logo_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              LogoWidget(size: 80.w),
              SizedBox(height: 40.h),
              Text(
                'Welcome to eChannelling',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                "Convenient for you, patient & specialist.\nPracttce everywhere quality healthcare through\nSri Lanka's leading telemedicine platform.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FeatureItem(
                        icon: Icons.security,
                        text: 'Secure Patient Consultations',
                        isCompleted: true,
                      ),
                      SizedBox(height: 20.h),
                      FeatureItem(
                        icon: Icons.medication,
                        text: 'Digital prescription management',
                        isCompleted: true,
                      ),
                      SizedBox(height: 20.h),
                      FeatureItem(
                        icon: Icons.phone,
                        text: 'Teleconsultations',
                        isCompleted: true,
                      ),
                      SizedBox(height: 20.h),
                      FeatureItem(
                        icon: Icons.analytics,
                        text: 'Income tracking and analytics',
                        isCompleted: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: 'Get Start',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isCompleted;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.text,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 16.sp, color: Colors.white),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
