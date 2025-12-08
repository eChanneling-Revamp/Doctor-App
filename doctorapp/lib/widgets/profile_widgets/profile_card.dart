import 'package:flutter/material.dart';
import '../share_widgets/buttons.dart';
import '../../screens/profile/edit_profile_screen.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String hospital;

  const ProfileCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Profile Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, size: 50, color: Colors.grey.shade400),
          ),

          const SizedBox(height: 16),

          // Doctor Name
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 4),

          // Specialty
          Text(
            specialty,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 8),

          // Hospital
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              hospital,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Edit Profile Button
          CustomButton(
            text: 'Edit Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            backgroundColor: const Color(0xFF4C40F7),
          ),
        ],
      ),
    );
  }
}
