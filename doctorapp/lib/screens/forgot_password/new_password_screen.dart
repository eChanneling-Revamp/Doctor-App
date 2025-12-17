import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/share_widgets/fingerprint_and_password.dart';
import '../../widgets/share_widgets/inputs.dart';
import '../../widgets/share_widgets/logo_widget.dart';
import '../signin_screen.dart';
import '../../utils/snackbar_utils.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Password validation
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasLowercase = false;
  bool _hasUppercase = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePassword(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
    });
  }

  void _resetPassword() {
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password.isEmpty || confirmPassword.isEmpty) {
      SnackbarUtils.info(context, 'Please fill in all fields');
      return;
    }

    if (password != confirmPassword) {
      SnackbarUtils.error(context, 'Passwords do not match');
      return;
    }

    if (!_hasMinLength || !_hasNumber || !_hasLowercase || !_hasUppercase) {
      SnackbarUtils.error(context, 'Password does not meet requirements');
      return;
    }

    // Password reset successful
    SnackbarUtils.success(context, 'Password reset successful!');

    // Navigate back to sign in
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
                  'Create new password',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 16.h),

                // Description
                Text(
                  'Your new password must be different from\npreviously used password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 32.h),

                // New Password Field
                CustomTextField(
                  hintText: '••••••••••••',
                  controller: _passwordController,
                  isPassword: !_isPasswordVisible,
                  onChanged: _validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                // Password Requirements
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PasswordStrengthIndicator(
                      label: 'Least 8 characters',
                      isValid: _hasMinLength,
                    ),
                    SizedBox(height: 4.h),
                    PasswordStrengthIndicator(
                      label: 'Least one number (0-9) or symbol',
                      isValid: _hasNumber,
                    ),
                    SizedBox(height: 4.h),
                    PasswordStrengthIndicator(
                      label: 'Lowercase (a-z) and uppercase (A-Z)',
                      isValid: _hasLowercase && _hasUppercase,
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Confirm Password Field
                CustomTextField(
                  hintText: 'Confirm new password',
                  controller: _confirmPasswordController,
                  isPassword: !_isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),

                SizedBox(height: 32.h),

                // Reset Password Button
                CustomButton(
                  text: 'Reset Password',
                  onPressed: _resetPassword,
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
