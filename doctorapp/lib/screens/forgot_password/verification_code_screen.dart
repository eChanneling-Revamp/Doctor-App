import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/share_widgets/inputs.dart';
import '../../widgets/share_widgets/logo_widget.dart';
import '../../utils/snackbar_utils.dart';
import 'new_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  String _verificationCode = '';

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controllers[index - 1].text.length,
        );
      }
    }

    _verificationCode = _controllers
        .map((controller) => controller.text)
        .join();
    setState(() {});
  }

  void _verify() {
    if (_verificationCode.length == 4) {
      // Navigate to new password screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NewPasswordScreen()),
      );
    } else {
      SnackbarUtils.error(
        context,
        'Please enter the complete verification code',
      );
    }
  }

  void _resendCode() {
    SnackbarUtils.success(context, 'Verification code resent!');
  }

  @override
  Widget build(BuildContext context) {
    final String email =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'your phone';

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
                  'Verification Code',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 16.h),

                // Description
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(
                        text:
                            'Please enter the 4 digit code sent to your mobile\nnumber ',
                      ),
                      TextSpan(
                        text: email,
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                // OTP Input Fields
                Row(
                  children: List.generate(4, (index) {
                    return Expanded(
                      child: OTPInputField(
                        controller: _controllers[index],
                        autoFocus: index == 0,
                        onChanged: (value) => _onCodeChanged(value, index),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 32.h),

                // Verify Button
                CustomButton(
                  text: 'Verify',
                  onPressed: _verify,
                  backgroundColor: const Color(0xFF4A3FFF),
                ),

                SizedBox(height: 24.h),

                // Resend Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't get the code? ",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: _resendCode,
                      child: Text(
                        'Resend code',
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
