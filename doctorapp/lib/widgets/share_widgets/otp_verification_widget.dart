import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'buttons.dart';
import 'logo_widget.dart';
import '../../utils/snackbar_utils.dart';
import '../../services/auth_service.dart';

class OTPVerificationWidget extends StatefulWidget {
  final String emailOrPhone;
  final String displayIdentifier;
  final String title;
  final bool showBackButton;
  final Function(BuildContext context) onVerificationSuccess;

  const OTPVerificationWidget({
    super.key,
    required this.emailOrPhone,
    required this.displayIdentifier,
    required this.title,
    required this.onVerificationSuccess,
    this.showBackButton = false,
  });

  @override
  State<OTPVerificationWidget> createState() => _OTPVerificationWidgetState();
}

class _OTPVerificationWidgetState extends State<OTPVerificationWidget> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  bool _isLoading = false;
  bool _isResending = false;
  int _remainingSeconds = 300; // 5 minutes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 300;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String get _timerDisplay {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }

    // Auto-submit when all 4 digits are entered
    if (index == 3 && value.isNotEmpty) {
      bool allFilled = _otpControllers.every((c) => c.text.isNotEmpty);
      if (allFilled) {
        _verifyOTP();
      }
    }
  }

  Future<void> _verifyOTP() async {
    String otp = _otpControllers.map((c) => c.text).join();

    if (otp.length != 4) {
      SnackbarUtils.error(context, 'Please enter complete OTP code');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await AuthService.verifyOtp(
        emailOrPhone: widget.emailOrPhone,
        code: otp,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (result['success']) {
          SnackbarUtils.success(context, result['message']);
          widget.onVerificationSuccess(context);
        } else {
          SnackbarUtils.error(context, result['message']);
          // Clear OTP fields on error
          for (var controller in _otpControllers) {
            controller.clear();
          }
          _focusNodes[0].requestFocus();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        SnackbarUtils.error(context, 'Verification failed. Please try again.');
      }
    }
  }

  Future<void> _resendOTP() async {
    if (_isResending) return;

    setState(() {
      _isResending = true;
    });

    try {
      final result = await AuthService.forgotPassword(
        emailOrPhone: widget.emailOrPhone,
      );

      if (mounted) {
        setState(() {
          _isResending = false;
        });

        if (result['success']) {
          SnackbarUtils.success(context, 'OTP resent successfully!');
          _startTimer();
          // Clear existing OTP
          for (var controller in _otpControllers) {
            controller.clear();
          }
          _focusNodes[0].requestFocus();
        } else {
          SnackbarUtils.error(context, result['message']);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
        SnackbarUtils.error(context, 'Failed to resend OTP. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.r),
      child: Column(
        children: [
          SizedBox(height: 40.h),

          // Logo
          LogoWidget(size: 60.w),

          SizedBox(height: 30.h),

          // Title
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 8.h),

          // Subtitle
          Text(
            'Enter the 4-digit code sent to',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            widget.displayIdentifier,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF4A3FFF),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 40.h),

          // OTP Input Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return SizedBox(
                width: 45.w,
                height: 55.h,
                child: TextField(
                  controller: _otpControllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  autofocus: index == 0,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF4A3FFF),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => _onOtpChanged(index, value),
                  onTap: () {
                    // Clear on tap for easier editing
                    _otpControllers[index].selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _otpControllers[index].text.length,
                    );
                  },
                  onEditingComplete: () {
                    if (index < 3) {
                      _focusNodes[index + 1].requestFocus();
                    }
                  },
                ),
              );
            }),
          ),

          SizedBox(height: 32.h),

          // Timer
          if (_remainingSeconds > 0)
            Text(
              'Code expires in $_timerDisplay',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            )
          else
            Text(
              'Code expired',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),

          SizedBox(height: 32.h),

          // Verify Button
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(color: const Color(0xFF4A3FFF)),
            )
          else
            CustomButton(text: 'Verify', onPressed: _verifyOTP),

          SizedBox(height: 24.h),

          // Resend Code
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Didn\'t receive the code? ',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
              ),
              GestureDetector(
                onTap: _isResending ? null : _resendOTP,
                child: Text(
                  _isResending ? 'Sending...' : 'Resend',
                  style: TextStyle(
                    color: _isResending
                        ? Colors.grey.shade400
                        : const Color(0xFF4A3FFF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          if (widget.showBackButton) ...[
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'Back to Sign In',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
