import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/teleconsultation_widgets/next_consultation_card.dart';
import '../../widgets/teleconsultation_widgets/consultation_list_view.dart';
import '../../services/teleconsultation_service.dart';
import 'call_page.dart';
import '../../utils/snackbar_utils.dart';

class TeleconsultScreen extends StatefulWidget {
  const TeleconsultScreen({super.key});

  @override
  State<TeleconsultScreen> createState() => _TeleconsultScreenState();
}

class _TeleconsultScreenState extends State<TeleconsultScreen> {
  // Toggle for viewing past consultations
  bool _showPast = false;

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

  // Past consultations list (filled when stopping a session)
  final List<Map<String, dynamic>> _pastConsultations = [];

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

  Future<void> _startConsultationNow({required String appointmentId}) async {
    // Let doctor choose Video vs Voice first
    final isVideo = await showModalBottomSheet<bool>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start consultation',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        icon: const Icon(Icons.videocam),
                        label: const Text('Video call'),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        icon: const Icon(Icons.call),
                        label: const Text('Voice call'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (isVideo == null) return; // dismissed

    // Doctor identity for 1:1 room per appointment
    final userId = TeleconsultationService.instance.currentDoctorUserId();
    const userName = 'Doctor';

    // Quick feedback to user
    SnackbarUtils.info(
      context,
      'Starting ${isVideo ? 'video' : 'voice'} call…',
      duration: const Duration(seconds: 2),
    );

    // Optional: fetch token from backend if configured
    String? token;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      token = await TeleconsultationService.instance.getZegoToken(
        userId: userId,
        appointmentId: appointmentId,
        role: 'doctor',
      );
    } finally {
      if (mounted) Navigator.of(context).pop();
    }

    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TeleconsultationCallPage(
          appointmentId: appointmentId,
          userId: userId,
          userName: userName,
          isVideo: isVideo,
          token: token,
        ),
      ),
    );
  }

  void _stopCurrentNextConsultation() {
    final current = nextConsultation;
    if (current == null) return;
    final id = current['id'];
    final index = _allAppointments.indexWhere(
      (a) => a['id'] == id && (a['type'] == 'Teleconsult'),
    );
    if (index >= 0) {
      setState(() {
        // Move to past consultations then remove from upcoming list
        _pastConsultations.insert(0, _allAppointments[index]);
        _allAppointments.removeAt(index);
      });
      SnackbarUtils.info(context, 'Stopped and moved to Past');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Teleconsult',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Next Consultation Card (only when viewing upcoming)
                if (!_showPast && nextConsultation != null)
                  NextConsultationCard(
                    consultation: nextConsultation!,
                    onStart: () {
                      final id = nextConsultation!['id'] as String;
                      _startConsultationNow(appointmentId: id);
                    },
                    onViewPHR: () {
                      // Handle view PHR
                    },
                    onStop: _stopCurrentNextConsultation,
                  ),
                SizedBox(height: 24.h),
                // Section header with Past toggle
                Row(
                  children: [
                    Text(
                      _showPast
                          ? 'Past Consultations'
                          : 'Upcoming Consultation',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => setState(() => _showPast = !_showPast),
                      child: Text(_showPast ? 'Upcoming' : 'Past'),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Consultation List
                ConsultationListView(
                  consultations: _showPast
                      ? _pastConsultations
                      : upcomingConsultations,
                  onStart: (consultation) {
                    final id = consultation['id'] as String;
                    _startConsultationNow(appointmentId: id);
                  },
                  emptyText: _showPast
                      ? 'No past teleconsultations'
                      : 'No upcoming teleconsultations',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
