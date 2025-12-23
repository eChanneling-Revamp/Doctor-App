import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/profile_widgets/profile_photo_section.dart';
import '../../widgets/profile_widgets/profile_form_fields.dart';
import '../../utils/snackbar_utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _slmcController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedSpecialty = 'Select your specialty';

  @override
  void initState() {
    super.initState();
    // Pre-fill with current data
    _fullNameController.text = 'Daniel Martinez';
    _selectedSpecialty = 'Cardiology';
    _hospitalController.text = 'Colombo General Hospital';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _hospitalController.dispose();
    _slmcController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.r),
            child: TextButton(
              onPressed: _saveProfile,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF4C40F7),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Photo Section
                const Center(child: ProfilePhotoSection()),

                SizedBox(height: 24.h),

                // Form Fields
                ProfileFormFields(
                  fullNameController: _fullNameController,
                  hospitalController: _hospitalController,
                  slmcController: _slmcController,
                  contactController: _contactController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  selectedSpecialty: _selectedSpecialty,
                  onSpecialtyChanged: (String? newValue) {
                    setState(() {
                      _selectedSpecialty = newValue!;
                    });
                  },
                ),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    // Validate fields
    if (_fullNameController.text.isEmpty) {
      SnackbarUtils.error(context, 'Please enter your full name');
      return;
    }

    // Save profile logic here
    SnackbarUtils.success(context, 'Profile updated successfully');
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) Navigator.pop(context);
    });
  }
}
