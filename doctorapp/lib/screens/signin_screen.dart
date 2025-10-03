import 'package:flutter/material.dart';
import '../widgets/shared_widgets.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    // Handle sign in logic
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // Navigate to home screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
    }
  }

  void _forgotPassword() {
    // Navigate to forgot password screen
    Navigator.pushNamed(context, '/forgot-password');
  }

  void _useFingerprint() {
    // Handle fingerprint authentication
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fingerprint authentication coming soon')),
    );
  }

  void _signUp() {
    // Navigate to sign up screen
    Navigator.pushNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  48,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Logo
                  const LogoWidget(size: 60),

                  const SizedBox(height: 30),

                  // Title
                  const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Welcome back! Please enter your details.',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 24),

                  // Email Field
                  CustomTextField(
                    hintText: 'edoctorapp@.com',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

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

                  const SizedBox(height: 16),

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

                  const SizedBox(height: 20),

                  // Sign In Button
                  CustomButton(
                    text: 'Sign in',
                    onPressed: _signIn,
                  ),

                  const SizedBox(height: 12),

                  // Forgot Password
                  TextButton(
                    onPressed: _forgotPassword,
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(
                        color: Color(0xFF4A3FFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Divider
                  const DividerWithText(text: 'Or'),

                  const SizedBox(height: 16),

                  // Fingerprint Button
                  FingerprintButton(onPressed: _useFingerprint),

                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you have an account? ',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: _signUp,
                        child: const Text(
                          'Sign up',
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
        ),
      ),
    );
  }
}
