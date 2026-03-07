import 'package:doctorapp/screens/app_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/share_widgets/buttons.dart';
import '../widgets/share_widgets/checkbox.dart';
import '../widgets/share_widgets/divider_with_text.dart';
import '../widgets/share_widgets/fingerprint_and_password.dart';
import '../widgets/share_widgets/inputs.dart';
import '../widgets/share_widgets/logo_widget.dart';
import 'forgot_password/forgot_password_screen.dart';
import 'signup/signup_screen.dart';
import '../utils/snackbar_utils.dart';
import '../services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    // Handle sign in logic
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      SnackbarUtils.info(context, 'Please enter email and password');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await AuthService.login(email: email, password: password);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (result['success']) {
          SnackbarUtils.success(context, result['message']);
          // Navigate to home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoctorMainApp()),
          );
        } else {
          SnackbarUtils.error(context, result['message']);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        SnackbarUtils.error(context, 'An error occurred. Please try again.');
      }
    }
  }

  void _forgotPassword() {
    // Navigate to forgot password screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  void _useFingerprint() {
    // Handle fingerprint authentication
    SnackbarUtils.info(context, 'Fingerprint authentication coming soon');
  }

  void _signUp() {
    // Navigate to sign up screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  48.h,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(height: 40.h),

                  // Logo
                  LogoWidget(size: 60.w),

                  SizedBox(height: 30.h),

                  // Title
                  Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Subtitle
                  Text(
                    'Welcome back! Please enter your details.',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Email Field
                  CustomTextField(
                    hintText: 'edoctorapp@domain.com',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 16.h),

                  // Password Field
                  CustomTextField(
                    hintText: 'Enter your password',
                    controller: _passwordController,
                    isPassword: !_isPasswordVisible,
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

                  // Remember me checkbox
                  Row(
                    children: [
                      CustomCheckbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        text: 'Remember information',
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Sign In Button
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF4A3FFF),
                          ),
                        )
                      : CustomButton(text: 'Sign in', onPressed: _signIn),

                  SizedBox(height: 12.h),

                  // Forgot Password
                  TextButton(
                    onPressed: _forgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Color(0xFF4A3FFF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Divider
                  const DividerWithText(text: 'Or'),

                  SizedBox(height: 16.h),

                  // Fingerprint Button
                  FingerprintButton(onPressed: _useFingerprint),

                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't you have an account? ",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: _signUp,
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color(0xFF4A3FFF),
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
      ),
    );
  }
}
