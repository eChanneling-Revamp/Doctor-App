import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../widgets/share_widgets/inputs.dart';
import '../../widgets/share_widgets/logo_widget.dart';
import '../../utils/snackbar_utils.dart';
import '../../utils/validation_utils.dart';
import '../signin_screen.dart';
import 'signup_photo_screen.dart';
import '../../models/signup_data.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _primaryHospitalController =
      TextEditingController();
  final TextEditingController _slmcNumberController = TextEditingController();

  String _selectedSpecialty = 'Select your specialty';

  // Error messages
  String? _fullNameError;
  String? _specialtyError;
  String? _hospitalError;
  String? _slmcError;

  @override
  void dispose() {
    _fullNameController.dispose();
    _primaryHospitalController.dispose();
    _slmcNumberController.dispose();
    super.dispose();
  }

  void _next() {
    // Clear previous errors
    setState(() {
      _fullNameError = null;
      _specialtyError = null;
      _hospitalError = null;
      _slmcError = null;
    });

    // Validate all fields
    bool hasError = false;

    final fullNameError = ValidationUtils.validateFullName(
      _fullNameController.text,
    );
    final specialtyError = ValidationUtils.validateSpecialty(
      _selectedSpecialty,
    );
    final hospitalError = ValidationUtils.validateHospital(
      _primaryHospitalController.text,
    );
    final slmcError = ValidationUtils.validateSLMCNumber(
      _slmcNumberController.text,
    );

    if (fullNameError != null) {
      setState(() => _fullNameError = fullNameError);
      hasError = true;
    }

    if (specialtyError != null) {
      setState(() => _specialtyError = specialtyError);
      hasError = true;
    }

    if (hospitalError != null) {
      setState(() => _hospitalError = hospitalError);
      hasError = true;
    }

    if (slmcError != null) {
      setState(() => _slmcError = slmcError);
      hasError = true;
    }

    if (hasError) {
      SnackbarUtils.error(context, 'Please fix the errors before continuing');
      return;
    }

    // Create signup data object
    final signupData = SignUpData(
      fullName: _fullNameController.text.trim(),
      medicalSpec: _selectedSpecialty,
      hospital: _primaryHospitalController.text.trim(),
      slmcNumber: int.tryParse(_slmcNumberController.text.trim()),
    );

    SnackbarUtils.success(context, 'Step 1 completed');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpPhotoScreen(signupData: signupData),
      ),
    );
  }

  void _signIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
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

              SizedBox(height: 30.h),

              // Title
              Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle
              Text(
                'Hello there! Let\'s create your account',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              ),

              SizedBox(height: 32.h),

              // Full Name Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: 'Your Name',
                    controller: _fullNameController,
                  ),
                  if (_fullNameError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        _fullNameError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 20.h),

              // Medical Specialty Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medical Specialty',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    height: 48.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _specialtyError != null
                            ? Colors.red
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSpecialty,
                        isExpanded: true,
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        items:
                            [
                              'Select your specialty',
                              'Cardiology',
                              'Dermatology',
                              'General Medicine',
                              'Pediatrics',
                              'Surgery',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: value == 'Select your specialty'
                                        ? Colors.grey.shade500
                                        : Colors.black87,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSpecialty = newValue!;
                            _specialtyError = null;
                          });
                        },
                      ),
                    ),
                  ),
                  if (_specialtyError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        _specialtyError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 20.h),

              // Primary Hospital Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Primary Hospital',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: 'Hospital Name',
                    controller: _primaryHospitalController,
                  ),
                  if (_hospitalError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        _hospitalError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 20.h),

              // SLMC Register Number Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SLMC Register Number',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    hintText: 'SLMC Number',
                    controller: _slmcNumberController,
                    keyboardType: TextInputType.number,
                  ),
                  if (_slmcError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        _slmcError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 32.h),

              // Next Button
              CustomButton(text: 'Next', onPressed: _next),

              SizedBox(height: 24.h),

              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do you have an account? ',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: _signIn,
                    child: Text(
                      'Sign in',
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
    );
  }
}
