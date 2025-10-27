import 'package:doctorapp/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/share_widgets/buttons.dart';
import '../widgets/share_widgets/logo_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Logo
              const LogoWidget(size: 80),

              const SizedBox(height: 40),

              // Title
              const Text(
                'Welcome to eChannelling',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Convenient for you, patient & specialist.\nPracttce everywhere quality healthcare through\nSri Lanka\'s leading telemedicine platform.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Feature List
              const Expanded(
                child: Column(
                  children: [
                    FeatureItem(
                      icon: Icons.security,
                      text: 'Secure Patient Consultations',
                      isCompleted: true,
                    ),
                    SizedBox(height: 20),
                    FeatureItem(
                      icon: Icons.medication,
                      text: 'Digital prescription management',
                      isCompleted: true,
                    ),
                    SizedBox(height: 20),
                    FeatureItem(
                      icon: Icons.phone,
                      text: 'Teleconsultations',
                      isCompleted: true,
                    ),
                    SizedBox(height: 20),
                    FeatureItem(
                      icon: Icons.analytics,
                      text: 'Income tracking and analytics',
                      isCompleted: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Get Start Button
              CustomButton(
                text: 'Get Start',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isCompleted;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.text,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
