import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../widgets/share_widgets/logo_widget.dart';
import '../signin_screen.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  void _signUp(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey.shade100, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  LogoWidget(size: 60.w),

                  SizedBox(height: 60.h),

                  // Success Icon and Modal
                  Container(
                    width: 200.w,
                    height: 280.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20.r,
                          offset: Offset(0, 10.h),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Success Icon
                        Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Title
                        Text(
                          'Congratulations!',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 12.h),

                        // Description
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          child: Text(
                            'Your account has been created and\nwill be activated in the next\nPage in a few seconds.',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Done Button
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: 'Done',
                              onPressed: () => _signUp(context),
                              height: 40.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
