import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';
import '../signin_screen.dart';
import 'signup_photo_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _medicalSpecialtyController =
      TextEditingController();
  final TextEditingController _primaryHospitalController =
      TextEditingController();
  final TextEditingController _slmcNumberController = TextEditingController();

  String _selectedSpecialty = 'Select your specialty';

  @override
  void dispose() {
    _fullNameController.dispose();
    _medicalSpecialtyController.dispose();
    _primaryHospitalController.dispose();
    _slmcNumberController.dispose();
    super.dispose();
  }

  void _next() {
    // Validate and navigate to next screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpPhotoScreen()),
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Logo
              const LogoWidget(size: 60),

              const SizedBox(height: 30),

              // Title
              const Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                'Hello there! Let\'s create your account',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 32),

              // Full Name Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: 'Your Name',
                    controller: _fullNameController,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Medical Specialty Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Medical Specialty',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSpecialty,
                        isExpanded: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    color:
                                        value == 'Select your specialty'
                                            ? Colors.grey.shade500
                                            : Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSpecialty = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Primary Hospital Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Primary Hospital',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: 'Hospital Name',
                    controller: _primaryHospitalController,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // SLMC Register Number Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SLMC Register Number',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: 'SLMC Number',
                    controller: _slmcNumberController,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Next Button
              CustomButton(text: 'Next', onPressed: _next),

              const SizedBox(height: 24),

              // Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do you have an account? ',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: _signIn,
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color(0xFF4A3FFF),
                        fontSize: 14,
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
