import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../widgets/share_widgets/inputs.dart';
import '../../widgets/share_widgets/logo_widget.dart';
import '../../utils/snackbar_utils.dart';
import '../../utils/validation_utils.dart';
import 'signup_otp_screen.dart';
import '../../models/signup_data.dart';
import '../../services/auth_service.dart';

class SignUpContactScreen extends StatefulWidget {
  final SignUpData signupData;

  const SignUpContactScreen({super.key, required this.signupData});

  @override
  State<SignUpContactScreen> createState() => _SignUpContactScreenState();
}

class _SignUpContactScreenState extends State<SignUpContactScreen> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  // Error messages
  String? _contactError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _contactController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _back() {
    Navigator.pop(context);
  }

  void _signUp() async {
    // Clear previous errors
    setState(() {
      _contactError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    // Validate and create account
    String contact = _contactController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Validate all fields
    bool hasError = false;

    final contactError = ValidationUtils.validatePhone(contact);
    final emailError = ValidationUtils.validateEmail(email);
    final passwordError = ValidationUtils.validatePassword(password);
    final confirmPasswordError = ValidationUtils.validateConfirmPassword(
      confirmPassword,
      password,
    );

    if (contactError != null) {
      setState(() => _contactError = contactError);
      hasError = true;
    }

    if (emailError != null) {
      setState(() => _emailError = emailError);
      hasError = true;
    }

    if (passwordError != null) {
      setState(() => _passwordError = passwordError);
      hasError = true;
    }

    if (confirmPasswordError != null) {
      setState(() => _confirmPasswordError = confirmPasswordError);
      hasError = true;
    }

    if (hasError) {
      SnackbarUtils.error(context, 'Please fix the errors before continuing');
      return;
    }

    // Update signup data with contact details
    widget.signupData.phone = contact;
    widget.signupData.email = email;
    widget.signupData.password = password;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await AuthService.register(
        fullName: widget.signupData.fullName!,
        email: widget.signupData.email!,
        phone: widget.signupData.phone!,
        password: widget.signupData.password!,
        medicalSpec: widget.signupData.medicalSpec!,
        hospital: widget.signupData.hospital!,
        slmcNumber: widget.signupData.slmcNumber!,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (result['success']) {
          SnackbarUtils.success(
            context,
            'Registration successful! Please verify your account.',
          );
          // Navigate to OTP verification screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpOTPScreen(
                emailOrPhone: email,
                displayIdentifier: email,
              ),
            ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: Column(
            children: [
              SizedBox(height: 40.h),

              // Logo
              LogoWidget(size: 60.w),

              SizedBox(height: 40.h),

              // Contact Number Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Number',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: 'Enter your contact number',
                    controller: _contactController,
                    keyboardType: TextInputType.phone,
                  ),
                  if (_contactError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        _contactError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 20.h),

              // Email Address Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: 'Enter your email address',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (_emailError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        _emailError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 20.h),

              // Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: 'Create a strong password',
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
                  if (_passwordError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        _passwordError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 20.h),

              // Confirm Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: 'Confirm your password',
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
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  if (_confirmPasswordError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        _confirmPasswordError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 32.h),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : _back,
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
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF4A3FFF),
                            ),
                          )
                        : CustomButton(text: 'Sign up', onPressed: _signUp),
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
