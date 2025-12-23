import 'package:doctorapp/screens/signup/signup_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../widgets/share_widgets/logo_widget.dart';
import '../../utils/snackbar_utils.dart';

class SignUpPhotoScreen extends StatefulWidget {
  const SignUpPhotoScreen({super.key});

  @override
  State<SignUpPhotoScreen> createState() => _SignUpPhotoScreenState();
}

class _SignUpPhotoScreenState extends State<SignUpPhotoScreen> {
  bool _hasPhoto = false;

  void _uploadPhoto() {
    // Handle photo upload
    setState(() {
      _hasPhoto = true;
    });
    SnackbarUtils.info(context, 'Photo upload feature coming soon');
  }

  void _back() {
    Navigator.pop(context);
  }

  void _next() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpContactScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            children: [
              SizedBox(height: 40.h),

              // Logo
              LogoWidget(size: 60.w),

              SizedBox(height: 80.h),

              // Profile Photo Section
              GestureDetector(
                onTap: _uploadPhoto,
                child: Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: _hasPhoto
                      ? Icon(Icons.person, size: 60.sp, color: Colors.grey)
                      : Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.person,
                                size: 60.sp,
                                color: Colors.grey,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 32.w,
                                height: 32.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4A3FFF),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              SizedBox(height: 24.h),

              // Text
              Text(
                'Personalize your account with a photo You\ncan always change it later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),

              const Spacer(),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _back,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomButton(text: 'Next', onPressed: _next),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
