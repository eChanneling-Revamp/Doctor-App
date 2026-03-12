import 'package:flutter/material.dart';
import '../../widgets/share_widgets/otp_verification_widget.dart';
import 'signup_success_screen.dart';

class SignUpOTPScreen extends StatelessWidget {
  final String emailOrPhone;
  final String displayIdentifier;

  const SignUpOTPScreen({
    super.key,
    required this.emailOrPhone,
    required this.displayIdentifier,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OTPVerificationWidget(
          emailOrPhone: emailOrPhone,
          displayIdentifier: displayIdentifier,
          title: 'Verify Your Account',
          showBackButton: true,
          onVerificationSuccess: (context) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpSuccessScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
