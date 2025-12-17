import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/share_widgets/inputs.dart';
import '../../widgets/share_widgets/logo_widget.dart';
import '../../utils/snackbar_utils.dart';
import 'verification_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendCode() {
    String email = _emailController.text.trim();
    if (email.isNotEmpty) {
      // Navigate to verification screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationCodeScreen(),
          settings: RouteSettings(arguments: email),
        ),
      );
    } else {
      SnackbarUtils.info(context, 'Please enter your email or phone number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const CustomBackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),

                // Logo
                LogoWidget(size: 60.w),

                SizedBox(height: 40.h),

                // Title
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 16.h),

                // Description
                Text(
                  'We need your registration phone number to send\nyou password reset code!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 40.h),

                // Email/Phone Field
                CustomTextField(
                  hintText: 'Enter your email or phone',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 24.h),

                // Send Code Button
                CustomButton(
                  text: 'Send Code',
                  onPressed: _sendCode,
                  backgroundColor: const Color(0xFF4A3FFF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
