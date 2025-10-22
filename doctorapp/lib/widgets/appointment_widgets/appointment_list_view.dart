import 'package:flutter/material.dart';
import 'appointment_card.dart';

class AppointmentListView extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  const AppointmentListView({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return AppointmentCard(
          name: appointment['name'],
          type: appointment['type'],
          time: appointment['time'],
          isConfirmed: appointment['isConfirmed'],
          initials: appointment['initials'],
        );
      },
    );
  }
}
