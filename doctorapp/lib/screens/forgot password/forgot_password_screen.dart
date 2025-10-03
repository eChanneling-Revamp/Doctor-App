import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';

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
      Navigator.pushNamed(context, '/verification', arguments: email);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email or phone number'),
        ),
      );
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // Logo
            const LogoWidget(size: 60),

            const SizedBox(height: 40),

            // Title
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              'We need your registration phone number to send\nyou password reset code!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            // Email/Phone Field
            CustomTextField(
              hintText: 'Enter your email or phone',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 24),

            // Send Code Button
            CustomButton(
              text: 'Send Code',
              onPressed: _sendCode,
              backgroundColor: const Color(0xFF4A3FFF),
            ),
          ],
        ),
      ),
    );
  }
}
