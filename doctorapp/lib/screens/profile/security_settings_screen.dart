import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/profile_widgets/settings_item.dart';
import '../../widgets/profile_widgets/change_password_section.dart';
import '../../utils/snackbar_utils.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security Settings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Manage Your Account Security',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Change Password Section
                const ChangePasswordSection(),

                SizedBox(height: 20.h),

                // Biometric Login
                SettingsItem(
                  icon: Icons.fingerprint,
                  iconColor: const Color(0xFF6D28D9),
                  iconBgColor: const Color(0xFFF3E8FF),
                  title: 'Biometric Login',
                  subtitle: 'Use fingerprint to login',
                  trailing: Switch(
                    value: _biometricEnabled,
                    onChanged: (value) {
                      setState(() {
                        _biometricEnabled = value;
                      });
                      SnackbarUtils.info(
                        context,
                        value
                            ? 'Biometric login enabled'
                            : 'Biometric login disabled',
                      );
                    },
                    activeColor: const Color(0xFF4C40F7),
                  ),
                  showArrow: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
