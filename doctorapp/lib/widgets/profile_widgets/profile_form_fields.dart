import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        Text(
          'Full Name',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(hintText: 'Your Name', controller: fullNameController),

        SizedBox(height: 20.h),

        // Medical Specialty
        Text(
          'Medical Specialty',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 48.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedSpecialty,
              isExpanded: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                          fontSize: 16.sp,
                        ),
                      ),
                    );
                  }).toList(),
              onChanged: onSpecialtyChanged,
            ),
          ),
        ),

        SizedBox(height: 20.h),

        // Primary Hospital
        Text(
          'Primary Hospital',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          hintText: 'Hospital Name',
          controller: hospitalController,
        ),

        SizedBox(height: 20.h),

        // SLMC Register Number
        Text(
          'SLMC Register Number',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(hintText: 'SLMC Number', controller: slmcController),

        SizedBox(height: 20.h),

        // Contact Number
        Text(
          'Contact Number',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          hintText: 'Enter your contact number',
          controller: contactController,
          keyboardType: TextInputType.phone,
        ),

        SizedBox(height: 20.h),

        // Email Address
        Text(
          'Email Address',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          hintText: 'Enter your email address',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),

        SizedBox(height: 20.h),

        // Password
        Text(
          'Password',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          hintText: '••••••••',
          controller: passwordController,
          isPassword: true,
        ),
      ],
    );
  }
}
