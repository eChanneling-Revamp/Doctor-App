import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'settings_item.dart';
import '../../utils/snackbar_utils.dart';
import '../../screens/profile/security_settings_screen.dart';
import '../../screens/profile/help_center_screen.dart';
import '../../screens/profile/terms_conditions_screen.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({super.key});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  bool _biometricEnabled = false;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),

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
                value ? 'Biometric login enabled' : 'Biometric login disabled',
              );
            },
            activeColor: const Color(0xFF4C40F7),
          ),
          showArrow: false,
        ),

        SizedBox(height: 12.h),

        // Terms and Conditions
        SettingsItem(
          icon: Icons.description_outlined,
          iconColor: const Color(0xFF4CAF50),
          iconBgColor: const Color(0xFFE8F5E9),
          title: 'Terms and Conditions',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TermsConditionsScreen(),
              ),
            );
          },
        ),

        SizedBox(height: 12.h),

        // App Theme
        SettingsItem(
          icon: Icons.wb_sunny_outlined,
          iconColor: const Color(0xFFFFA726),
          iconBgColor: const Color(0xFFFFF3E0),
          title: 'App Theme',
          subtitle: 'Switch off to Dark mode',
          trailing: Switch(
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
              SnackbarUtils.info(
                context,
                value ? 'Dark mode enabled' : 'Light mode enabled',
              );
            },
            activeColor: const Color(0xFF4C40F7),
          ),
          showArrow: false,
        ),

        SizedBox(height: 12.h),

        // Security
        SettingsItem(
          icon: Icons.lock_outline,
          iconColor: const Color(0xFFF44336),
          iconBgColor: const Color(0xFFFFEBEE),
          title: 'Security',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecuritySettingsScreen(),
              ),
            );
          },
        ),

        SizedBox(height: 12.h),

        // Help Center
        SettingsItem(
          icon: Icons.help_outline,
          iconColor: const Color(0xFF2196F3),
          iconBgColor: const Color(0xFFE3F2FD),
          title: 'Help Center',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
            );
          },
        ),
      ],
    );
  }
}
