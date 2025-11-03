import 'package:flutter/material.dart';
import '../../widgets/teleconsultation_widgets/next_consultation_card.dart';
import '../../widgets/teleconsultation_widgets/consultation_list_view.dart';

class TeleconsultScreen extends StatefulWidget {
  const TeleconsultScreen({super.key});

  @override
  State<TeleconsultScreen> createState() => _TeleconsultScreenState();
}

class _TeleconsultScreenState extends State<TeleconsultScreen> {
  // Sample data from appointments - filtered for teleconsult
  // In a real app, this would come from a shared provider/state management
  final List<Map<String, dynamic>> _allAppointments = [
    {
      'name': 'Mary De Silva',
      'type': 'Teleconsult',
      'time': '10:30am - 11:30am',
      'isConfirmed': true,
      'initials': 'MD',
      'day': 'Today',
      'id': '0002025020',
    },
    {
      'name': 'Meera Silva',
      'type': 'Teleconsult',
      'time': '7:00 PM - 9:00 PM',
      'isConfirmed': true,
      'initials': 'MS',
      'day': 'Today',
      'id': '0002025021',
    },
    {
      'name': 'Gayani Maloha',
      'type': 'Teleconsult',
      'time': '3:00 PM - 5:00 PM',
      'isConfirmed': false,
      'initials': 'GM',
      'day': 'Today',
      'id': '0002025022',
    },
    {
      'name': 'Neera Fernando',
      'type': 'Teleconsult',
      'time': '7:00 PM - 9:00 PM',
      'isConfirmed': true,
      'initials': 'NF',
      'day': 'Tomorrow',
      'id': '0002025023',
    },
    {
      'name': 'David Gamage',
      'type': 'Teleconsult',
      'time': '10:00 AM - 11:00 AM',
      'isConfirmed': true,
      'initials': 'DG',
      'day': 'Tomorrow',
      'id': '0002025024',
    },
  ];

  // Get teleconsult appointments only
  List<Map<String, dynamic>> get upcomingConsultations {
    return _allAppointments
        .where((appointment) => appointment['type'] == 'Teleconsult')
        .toList();
  }

  // Get next consultation (first in the list)
  Map<String, dynamic>? get nextConsultation {
    final upcoming = upcomingConsultations;
    return upcoming.isNotEmpty ? upcoming.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Teleconsult',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Next Consultation Card
            if (nextConsultation != null)
              NextConsultationCard(
                consultation: nextConsultation!,
                onStart: () {
                  // Handle start consultation
                },
                onViewPHR: () {
                  // Handle view PHR
                },
              ),
            const SizedBox(height: 24),
            // Upcoming Consultation Section
            const Text(
              'Upcoming Consultation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            // Consultation List
            ConsultationListView(
              consultations: upcomingConsultations,
              onEdit: (consultation) {
                // Handle edit consultation
              },
              onDelete: (consultation) {
                // Handle delete consultation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Delete appointment: ${consultation['name']}',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
