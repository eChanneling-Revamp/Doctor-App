import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/snackbar_utils.dart';

class ProfilePhotoSection extends StatelessWidget {
  const ProfilePhotoSection({super.key});

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
        ),
        child: Column(
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
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
