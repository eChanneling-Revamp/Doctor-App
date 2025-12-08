import 'package:flutter/material.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/profile_widgets/profile_card.dart';
import '../../widgets/profile_widgets/settings_section.dart';
import '../../widgets/profile_widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Card
            const ProfileCard(
              name: 'Daniel Martinez',
              specialty: 'Cardiologist',
              hospital: 'Colombo General Hospital',
            ),

            const SizedBox(height: 24),

            // Settings Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SettingsSection(),
            ),

            const SizedBox(height: 32),

            // Logout Button
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: LogoutButton(),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
