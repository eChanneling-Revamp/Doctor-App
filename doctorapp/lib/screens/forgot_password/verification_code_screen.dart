import 'package:flutter/material.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/share_widgets/otp_verification_widget.dart';
import 'new_password_screen.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String emailOrPhone;

  const VerificationCodeScreen({super.key, required this.emailOrPhone});

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
        child: OTPVerificationWidget(
          emailOrPhone: emailOrPhone,
          displayIdentifier: emailOrPhone,
          title: 'Verification Code',
          showBackButton: false,
          onVerificationSuccess: (context) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NewPasswordScreen(emailOrPhone: emailOrPhone),
              ),
            );
          },
        ),
      ),
    );
  }
}
