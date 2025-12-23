import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/snackbar_utils.dart';

class ExportButtons extends StatelessWidget {
  const ExportButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              SnackbarUtils.info(context, 'Exporting CSV...');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53E3E),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
            ),
            icon: Icon(Icons.download, size: 20.r),
            label: Text(
              'Export CSV',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              SnackbarUtils.info(context, 'Exporting PDF...');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              side: const BorderSide(color: Colors.white, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            icon: Icon(Icons.picture_as_pdf, size: 20.r),
            label: Text(
              'Export PDF',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
