import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/snackbar_utils.dart';
import 'appointment_card.dart';

class AppointmentListView extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  const AppointmentListView({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: appointments.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return AppointmentCard(
          name: appointment['name'],
          type: appointment['type'],
          time: appointment['time'],
          isConfirmed: appointment['isConfirmed'],
          initials: appointment['initials'],
          onTap: () {
            SnackbarUtils.info(
              context,
              'Appointment with ${appointment['name']}',
            );
          },
        );
      },
    );
  }
}
