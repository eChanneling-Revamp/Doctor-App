import 'package:flutter/material.dart';
import '../share_widgets/inputs.dart';
import '../share_widgets/buttons.dart';
import '../../utils/snackbar_utils.dart';

class ChangePasswordSection extends StatefulWidget {
  const ChangePasswordSection({super.key});

  @override
  State<ChangePasswordSection> createState() => _ChangePasswordSectionState();
}

class _ChangePasswordSectionState extends State<ChangePasswordSection> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Password validation states
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasLowercase = false;
  bool _hasUppercase = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
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

  void _changePassword() {
    // Validate fields
    if (_currentPasswordController.text.isEmpty) {
      SnackbarUtils.error(context, 'Please enter current password');
      return;
    }

    if (_newPasswordController.text.isEmpty) {
      SnackbarUtils.error(context, 'Please enter new password');
      return;
    }

    if (!_hasMinLength || !_hasNumber || !_hasLowercase || !_hasUppercase) {
      SnackbarUtils.error(context, 'Password does not meet requirements');
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      SnackbarUtils.error(context, 'Passwords do not match');
      return;
    }

    // Change password logic here
    SnackbarUtils.success(context, 'Password changed successfully');
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Update Your Account Password',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),

          // Current Password
          CustomTextField(
            hintText: 'Enter Current Password',
            controller: _currentPasswordController,
            isPassword: _obscureCurrentPassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureCurrentPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureCurrentPassword = !_obscureCurrentPassword;
                });
              },
            ),
          ),

          const SizedBox(height: 16),

          // New Password
          CustomTextField(
            hintText: 'Enter New Password',
            controller: _newPasswordController,
            isPassword: _obscureNewPassword,
            onChanged: _validatePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureNewPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureNewPassword = !_obscureNewPassword;
                });
              },
            ),
          ),

          const SizedBox(height: 16),

          // Confirm Password
          CustomTextField(
            hintText: 'Confirm new Password',
            controller: _confirmPasswordController,
            isPassword: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
          ),

          const SizedBox(height: 16),

          // Password Requirements
          _PasswordRequirement(
            text: 'Least 8 characters',
            isMet: _hasMinLength,
          ),
          _PasswordRequirement(
            text: 'Least one number (0-9) or symbol',
            isMet: _hasNumber,
          ),
          _PasswordRequirement(
            text: 'Lowercase (a-z) and uppercase (A-Z)',
            isMet: _hasLowercase && _hasUppercase,
          ),

          const SizedBox(height: 20),

          // Change Password Button
          CustomButton(
            text: 'Change Password',
            onPressed: _changePassword,
            backgroundColor: const Color(0xFF4C40F7),
          ),
        ],
      ),
    );
  }
}

class _PasswordRequirement extends StatelessWidget {
  final String text;
  final bool isMet;

  const _PasswordRequirement({required this.text, required this.isMet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: isMet ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isMet ? Colors.green : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
