import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../share_widgets/buttons.dart';
import '../../../../utils/snackbar_utils.dart';

class ScheduleActionButtons extends StatelessWidget {
  final VoidCallback onUpdate;
  final VoidCallback onCancel;

  const ScheduleActionButtons({
    super.key,
    required this.onUpdate,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Update',
            onPressed: () {
              onUpdate();
              SnackbarUtils.success(context, 'Schedule updated successfully');
            },
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomButton(
            text: 'Cancel',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            borderColor: Colors.black,
            onPressed: onCancel,
          ),
        ),
      ],
    );
  }
}
