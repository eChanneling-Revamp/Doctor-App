import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/snackbar_utils.dart';

class ProfilePhotoSection extends StatelessWidget {
  final String? profileImage;

  const ProfilePhotoSection({super.key, this.profileImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SnackbarUtils.info(context, 'Photo upload coming soon');
      },
      child: Container(
        width: double.infinity,
        height: 160.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
          image: profileImage != null
              ? DecorationImage(
                  image: NetworkImage(profileImage!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: profileImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 48.r,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Click camera icon to change photo',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              )
            : Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    radius: 20.r,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20.r,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
