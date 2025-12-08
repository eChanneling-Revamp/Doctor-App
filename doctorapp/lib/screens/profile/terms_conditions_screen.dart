import 'package:flutter/material.dart';
import '../../widgets/share_widgets/custom_back_button.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last Updated
            Text(
              'Last updated: December 02, 2025',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),

            // Introduction
            const Text(
              'Welcome to eChanneling Pro',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'These Terms and Conditions govern your use of the eChanneling Pro mobile application and services. By accessing or using our platform, you agree to be bound by these terms.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.grey.shade800,
              ),
            ),

            const SizedBox(height: 24),

            // Section 1
            _buildSection(
              '1. Acceptance of Terms',
              'By creating an account and using eChanneling Pro, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you must not use our services.',
            ),

            // Section 2
            _buildSection(
              '2. Eligibility',
              'You must be a licensed medical practitioner registered with the Sri Lanka Medical Council (SLMC) to use this platform. You agree to provide accurate, current, and complete information during registration and maintain the accuracy of such information.',
            ),

            // Section 3
            _buildSection(
              '3. Account Security',
              'You are responsible for maintaining the confidentiality of your account credentials. You agree to:\n\n• Use a strong, unique password\n• Not share your account with others\n• Notify us immediately of any unauthorized access\n• Accept responsibility for all activities under your account',
            ),

            // Section 4
            _buildSection(
              '4. Professional Conduct',
              'As a healthcare professional, you agree to:\n\n• Maintain professional standards in all patient interactions\n• Comply with medical ethics and regulations\n• Provide accurate medical information and documentation\n• Respect patient confidentiality and privacy\n• Follow telemedicine guidelines and best practices',
            ),

            // Section 5
            _buildSection(
              '5. Service Usage',
              'You may use our platform to:\n\n• Manage appointments and schedules\n• Conduct teleconsultations\n• Issue electronic prescriptions\n• Access patient health records\n• Track income and payments\n\nYou agree not to misuse the platform or use it for any unlawful purposes.',
            ),

            // Section 6
            _buildSection(
              '6. Patient Data and Privacy',
              'You acknowledge that patient data is sensitive and confidential. You agree to:\n\n• Handle patient information in compliance with data protection laws\n• Use patient data only for legitimate medical purposes\n• Implement appropriate security measures\n• Report any data breaches immediately',
            ),

            // Section 7
            _buildSection(
              '7. Teleconsultation Guidelines',
              'When conducting teleconsultations, you must:\n\n• Verify patient identity before consultation\n• Ensure appropriate technology and environment\n• Maintain the same professional standards as in-person consultations\n• Document consultations properly\n• Only prescribe medications when clinically appropriate',
            ),

            // Section 8
            _buildSection(
              '8. Payment and Fees',
              'You understand that:\n\n• Service fees apply as per the agreed pricing structure\n• Payments are processed through secure channels\n• You are responsible for applicable taxes\n• Refund policies apply as specified in our refund policy',
            ),

            // Section 9
            _buildSection(
              '9. Intellectual Property',
              'All content, features, and functionality of eChanneling Pro are owned by us and protected by copyright, trademark, and other intellectual property laws. You may not copy, modify, distribute, or create derivative works without our permission.',
            ),

            // Section 10
            _buildSection(
              '10. Limitation of Liability',
              'To the maximum extent permitted by law, eChanneling Pro and its affiliates shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising from your use of the platform.',
            ),

            // Section 11
            _buildSection(
              '11. Service Availability',
              'We strive to maintain service availability but do not guarantee uninterrupted access. We may modify, suspend, or discontinue any aspect of the service at any time with or without notice.',
            ),

            // Section 12
            _buildSection(
              '12. Termination',
              'We reserve the right to suspend or terminate your account if:\n\n• You violate these Terms and Conditions\n• You engage in fraudulent activities\n• Your medical license is revoked or suspended\n• We determine termination is necessary to protect users',
            ),

            // Section 13
            _buildSection(
              '13. Changes to Terms',
              'We may update these Terms and Conditions from time to time. We will notify you of significant changes through the app or email. Your continued use of the platform after changes constitutes acceptance of the updated terms.',
            ),

            // Section 14
            _buildSection(
              '14. Governing Law',
              'These Terms and Conditions are governed by the laws of Sri Lanka. Any disputes arising from these terms shall be subject to the exclusive jurisdiction of the courts of Sri Lanka.',
            ),

            // Section 15
            _buildSection(
              '15. Contact Information',
              'If you have questions about these Terms and Conditions, please contact us at:\n\nEmail: support@echanneling.com\nPhone: +94 11 123 4567\nAddress: Colombo, Sri Lanka',
            ),

            const SizedBox(height: 32),

            // Acceptance Checkbox Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFF4C40F7),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'By using eChanneling Pro, you acknowledge that you have read and agree to these Terms and Conditions.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
