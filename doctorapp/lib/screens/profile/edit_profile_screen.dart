import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/profile_widgets/profile_photo_section.dart';
import '../../widgets/profile_widgets/profile_form_fields.dart';
import '../../utils/snackbar_utils.dart';
import '../../services/profile_service.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? profileData;

  const EditProfileScreen({super.key, this.profileData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _slmcController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _selectedSpecialty = 'Select your specialty';
  bool _isLoading = false;
  Map<String, dynamic>? _profileData;
  final _formKey = GlobalKey<ProfileFormFieldsState>();

  @override
  void initState() {
    super.initState();
    if (widget.profileData != null) {
      _loadProfileData(widget.profileData!);
    } else {
      _fetchProfile();
    }
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
    });

    final result = await ProfileService.getProfile();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (result['success']) {
        _loadProfileData(result['data']);
      } else {
        SnackbarUtils.error(
          context,
          result['message'] ?? 'Failed to load profile',
        );
      }
    }
  }

  void _loadProfileData(Map<String, dynamic> data) {
    setState(() {
      _profileData = data;
      _fullNameController.text = data['name'] ?? '';
      _selectedSpecialty = data['medicalSpecs'] ?? 'Select your specialty';
      _hospitalController.text = data['hospital'] ?? '';
      // slmcNumber is stored as Int in DB, so convert to String
      _slmcController.text = data['slmcNumber']?.toString() ?? '';
      _contactController.text = data['contactNumber'] ?? '';
      _emailController.text = data['email'] ?? '';
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _hospitalController.dispose();
    _slmcController.dispose();
    _contactController.dispose();
    _emailController.dispose();
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
              onPressed: _isLoading ? null : _saveProfile,
              style: TextButton.styleFrom(
                backgroundColor: _isLoading
                    ? Colors.grey
                    : const Color(0xFF4C40F7),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: _isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
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
      body: _profileData == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Photo Section
                      Center(
                        child: ProfilePhotoSection(
                          profileImage: _profileData?['profileImage'],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Form Fields
                      ProfileFormFields(
                        key: _formKey,
                        fullNameController: _fullNameController,
                        hospitalController: _hospitalController,
                        slmcController: _slmcController,
                        contactController: _contactController,
                        emailController: _emailController,
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

  Future<void> _saveProfile() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
    });

    final result = await ProfileService.updateProfile(
      fullName: _fullNameController.text,
      email: _emailController.text,
      phone: _contactController.text,
      medicalSpec: _selectedSpecialty,
      hospital: _hospitalController.text,
      slmcNumber: _slmcController.text,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (result['success']) {
        SnackbarUtils.success(
          context,
          result['message'] ?? 'Profile updated successfully',
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted)
            Navigator.pop(context, true); // Return true to trigger refresh
        });
      } else {
        SnackbarUtils.error(
          context,
          result['message'] ?? 'Failed to update profile',
        );
      }
    }
  }
}
