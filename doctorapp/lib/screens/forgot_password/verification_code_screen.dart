import 'package:flutter/material.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/share_widgets/inputs.dart';
import '../../widgets/share_widgets/logo_widget.dart';
import '../../utils/snackbar_utils.dart';
import 'new_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  String _verificationCode = '';

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controllers[index - 1].text.length,
        );
      }
    }

    _verificationCode =
        _controllers.map((controller) => controller.text).join();
    setState(() {});
  }

  void _verify() {
    if (_verificationCode.length == 4) {
      // Navigate to new password screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NewPasswordScreen()),
      );
    } else {
      SnackbarUtils.error(
        context,
        'Please enter the complete verification code',
      );
    }
  }

  void _resendCode() {
    SnackbarUtils.success(context, 'Verification code resent!');
  }

  @override
  Widget build(BuildContext context) {
    final String email =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'your phone';

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
              'Verification Code',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // Description
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                    text:
                        'Please enter the 4 digit code sent to your mobile\nnumber ',
                  ),
                  TextSpan(
                    text: '+40 700 000 000',
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return OTPInputField(
                  controller: _controllers[index],
                  autoFocus: index == 0,
                  onChanged: (value) => _onCodeChanged(value, index),
                );
              }),
            ),

            const SizedBox(height: 32),

            // Verify Button
            CustomButton(
              text: 'Verify',
              onPressed: _verify,
              backgroundColor: const Color(0xFF4A3FFF),
            ),

            const SizedBox(height: 24),

            // Resend Code
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't get the code? ",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                GestureDetector(
                  onTap: _resendCode,
                  child: Text(
                    'Resend code',
                    style: TextStyle(
                      color: Colors.blue.shade600,
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
    );
  }
}
