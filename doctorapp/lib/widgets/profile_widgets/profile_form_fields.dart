import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../share_widgets/inputs.dart';
import '../../utils/validation_utils.dart';

class ProfileFormFields extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController hospitalController;
  final TextEditingController slmcController;
  final TextEditingController contactController;
  final TextEditingController emailController;
  final String selectedSpecialty;
  final ValueChanged<String?> onSpecialtyChanged;

  const ProfileFormFields({
    super.key,
    required this.fullNameController,
    required this.hospitalController,
    required this.slmcController,
    required this.contactController,
    required this.emailController,
    required this.selectedSpecialty,
    required this.onSpecialtyChanged,
  });

  @override
  State<ProfileFormFields> createState() => ProfileFormFieldsState();
}

class ProfileFormFieldsState extends State<ProfileFormFields> {
  String? _fullNameError;
  String? _specialtyError;
  String? _hospitalError;
  String? _contactError;

  bool validate() {
    setState(() {
      _fullNameError = ValidationUtils.validateFullName(
        widget.fullNameController.text,
      );
      _specialtyError = widget.selectedSpecialty == 'Select your specialty'
          ? 'Please select your medical specialty'
          : null;
      _hospitalError = ValidationUtils.validateHospital(
        widget.hospitalController.text,
      );
      _contactError = ValidationUtils.validatePhone(
        widget.contactController.text,
      );
    });
    return _fullNameError == null &&
        _specialtyError == null &&
        _hospitalError == null &&
        _contactError == null;
  }

  Widget _errorText(String? error) {
    if (error == null) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Text(
        error,
        style: TextStyle(fontSize: 12.sp, color: Colors.red),
      ),
    );
  }

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
        CustomTextField(
          hintText: 'Your Name',
          controller: widget.fullNameController,
          onChanged: (_) => setState(() {
            _fullNameError = ValidationUtils.validateFullName(
              widget.fullNameController.text,
            );
          }),
        ),
        _errorText(_fullNameError),

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
            border: Border.all(
              color: _specialtyError != null
                  ? Colors.red
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.selectedSpecialty,
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
              onChanged: (val) {
                widget.onSpecialtyChanged(val);
                setState(() {
                  _specialtyError = val == 'Select your specialty'
                      ? 'Please select your medical specialty'
                      : null;
                });
              },
            ),
          ),
        ),
        _errorText(_specialtyError),

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
          controller: widget.hospitalController,
          onChanged: (_) => setState(() {
            _hospitalError = ValidationUtils.validateHospital(
              widget.hospitalController.text,
            );
          }),
        ),
        _errorText(_hospitalError),

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
        CustomTextField(
          hintText: 'SLMC Number',
          controller: widget.slmcController,
          readOnly: true,
        ),

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
          controller: widget.contactController,
          keyboardType: TextInputType.phone,
          onChanged: (_) => setState(() {
            _contactError = ValidationUtils.validatePhone(
              widget.contactController.text,
            );
          }),
        ),
        _errorText(_contactError),

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
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          readOnly: true,
        ),
      ],
    );
  }
}
