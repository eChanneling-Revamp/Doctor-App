import 'package:flutter/material.dart';
import '../../widgets/session_widgets/active_session.dart';
import '../home/add_session_screen.dart';
import '../../widgets/session_widgets/session_filter_row.dart';
import '../../widgets/session_widgets/session_section.dart';
import '../../widgets/share_widgets/buttons.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

// Simple internal model for demo session data
class _Session {
  final String hospitalName;
  final String patientCount;
  final String time;
  final String sessionType;
  final Color iconColor;
  final String note;

  const _Session({
    required this.hospitalName,
    required this.patientCount,
    required this.time,
    required this.sessionType,
    required this.iconColor,
    required this.note,
  });
}

class _SessionScreenState extends State<SessionScreen> {
  String _selectedFilter = 'All';

  // sample data - in a real app this would come from a provider / API
  final List<_Session> _todayData = const [
    _Session(
      hospitalName: 'Hemas Hospital',
      patientCount: '10/20 Patients (H001)',
      time: '5.00 PM',
      sessionType: 'Hospital',
      iconColor: Color(0xFF10B981),
      note: 'General Consultation Hours',
    ),
    _Session(
      hospitalName: 'Online Consultation',
      patientCount: '8/10 Patients',
      time: '7.00 PM - 9.00 PM',
      sessionType: 'Teleconsultation',
      iconColor: Color(0xFF6D28D9),
      note: 'Video Consultation Slots',
    ),
    _Session(
      hospitalName: 'Online Consultation',
      patientCount: '8/10 Patients',
      time: '7.00 PM - 9.00 PM',
      sessionType: 'Teleconsultation',
      iconColor: Color(0xFF6D28D9),
      note: 'Video Consultation Slots',
    ),
  ];

  final List<_Session> _tomorrowData = const [
    _Session(
      hospitalName: 'Online Consultation',
      patientCount: '8/10 Patients',
      time: '7.00 PM - 9.00 PM',
      sessionType: 'Teleconsultation',
      iconColor: Color(0xFF6D28D9),
      note: 'Video Consultation Slots',
    ),
    _Session(
      hospitalName: 'Hemas Hospital',
      patientCount: '10/20 Patients (H001)',
      time: '5.00 PM',
      sessionType: 'Hospital',
      iconColor: Color(0xFF10B981),
      note: 'General Consultation Hours',
    ),
  ];

  List<_Session> _applyFilter(List<_Session> list) {
    if (_selectedFilter == 'All') return list;
    return list.where((s) => s.sessionType == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final todaySessions = _applyFilter(_todayData);
    final tomorrowSessions = _applyFilter(_tomorrowData);

    final int activeFilterCount = _selectedFilter == 'All' ? 0 : 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Session Management',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                CustomOutlinedButton(
                  text: 'Add Session',
                  onPressed:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddSessionScreen(),
                        ),
                      ),
                  borderColor: const Color(0xFF4A3FFF),
                  textColor: const Color(0xFF4A3FFF),
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Filter row (extracted widget)
              SessionFilterRow(
                selectedFilter: _selectedFilter,
                activeFilterCount: activeFilterCount,
                onSelected: (value) => setState(() => _selectedFilter = value),
              ),

              const SizedBox(height: 16),

              SessionSection(
                title: 'Today - Oct 24, 2025',
                children:
                    todaySessions
                        .map(
                          (s) => ActiveSessionItem(
                            hospitalName: s.hospitalName,
                            patientCount: s.patientCount,
                            time: s.time,
                            sessionType: s.sessionType,
                            note: s.note,
                            iconColor: s.iconColor,
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: 16),

              SessionSection(
                title: 'Tomorrow - Oct 25, 2025',
                children:
                    tomorrowSessions
                        .map(
                          (s) => ActiveSessionItem(
                            hospitalName: s.hospitalName,
                            patientCount: s.patientCount,
                            time: s.time,
                            sessionType: s.sessionType,
                            note: s.note,
                            iconColor: s.iconColor,
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
