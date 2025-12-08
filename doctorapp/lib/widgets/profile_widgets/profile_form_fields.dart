import 'package:flutter/material.dart';
import '../share_widgets/inputs.dart';

class ProfileFormFields extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController hospitalController;
  final TextEditingController slmcController;
  final TextEditingController contactController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String selectedSpecialty;
  final ValueChanged<String?> onSpecialtyChanged;

  const ProfileFormFields({
    super.key,
    required this.fullNameController,
    required this.hospitalController,
    required this.slmcController,
    required this.contactController,
    required this.emailController,
    required this.passwordController,
    required this.selectedSpecialty,
    required this.onSpecialtyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name
        const Text(
          'Full Name',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(hintText: 'Your Name', controller: fullNameController),

        const SizedBox(height: 20),

        // Medical Specialty
        const Text(
          'Medical Specialty',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedSpecialty,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              items:
                  [
                    'Select your specialty',
                    'Cardiology',
                    'Dermatology',
                    'General Medicine',
                    'Pediatrics',
                    'Surgery',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: value == 'Select your specialty'
                              ? Colors.grey.shade500
                              : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
              onChanged: onSpecialtyChanged,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Primary Hospital
        const Text(
          'Primary Hospital',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'Hospital Name',
          controller: hospitalController,
        ),

        const SizedBox(height: 20),

        // SLMC Register Number
        const Text(
          'SLMC Register Number',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(hintText: 'SLMC Number', controller: slmcController),

        const SizedBox(height: 20),

        // Contact Number
        const Text(
          'Contact Number',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'Enter your contact number',
          controller: contactController,
          keyboardType: TextInputType.phone,
        ),

        const SizedBox(height: 20),

        // Email Address
        const Text(
          'Email Address',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'Enter your email address',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 20),

        // Password
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: '••••••••',
          controller: passwordController,
          isPassword: true,
        ),
      ],
    );
  }
}
