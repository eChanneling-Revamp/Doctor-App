import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../share_widgets/buttons.dart';
import '../../screens/profile/edit_profile_screen.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String hospital;
  final String? profileImage;
  final VoidCallback? onProfileUpdated;
  final Map<String, dynamic>? fullProfileData;

  const ProfileCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.hospital,
    this.profileImage,
    this.onProfileUpdated,
    this.fullProfileData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Profile Image
          Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
              image: profileImage != null
                  ? DecorationImage(
                      image: NetworkImage(profileImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: profileImage == null
                ? Icon(Icons.person, size: 50.r, color: Colors.grey.shade400)
                : null,
          ),

          SizedBox(height: 16.h),

          // Doctor Name
          Text(
            name,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 4.h),

          // Specialty
          Text(
            specialty,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),

          SizedBox(height: 8.h),

          // Hospital
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              hospital,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF2E7D32),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Edit Profile Button
          CustomButton(
            text: 'Edit Profile',
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    profileData:
                        fullProfileData ??
                        {
                          'name': name,
                          'medicalSpecs': specialty,
                          'hospital': hospital,
                          'profileImage': profileImage,
                        },
                  ),
                ),
              );
              // Trigger parent refresh if profile was updated
              if (result == true && onProfileUpdated != null) {
                onProfileUpdated!();
              }
            },
            backgroundColor: const Color(0xFF4C40F7),
          ),
        ],
      ),
    );
  }
}
