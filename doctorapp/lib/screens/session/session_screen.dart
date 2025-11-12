import 'package:flutter/material.dart';
import '../../widgets/session_widgets/active_session.dart';
import '../home/add_session_screen.dart';
import '../../widgets/session_widgets/session_filter_row.dart';
import '../../widgets/session_widgets/session_section.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../utils/session_utils.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

// Simple internal model for demo session data
class _Session {
  final String hospitalName;
  final String patientCount;
  final String date;
  final String time;
  final String sessionType;
  final Color iconColor;
  final String note;

  const _Session({
    required this.hospitalName,
    required this.patientCount,
    required this.date,
    required this.time,
    required this.sessionType,
    required this.iconColor,
    required this.note,
  });
}

class _SessionScreenState extends State<SessionScreen> {
  String _selectedFilter = 'All';

  // sample data - in a real app this would come from a provider / API
  final List<_Session> _todayData = [
    _Session(
      hospitalName: 'Hemas Hospital',
      patientCount: '10/20 Patients (H001)',
      date: '05/11/2025',
      time: '5.00 PM',
      sessionType: 'Hospital',
      iconColor: Color(0xFF10B981),
      note: 'General Consultation Hours',
    ),
    _Session(
      hospitalName: 'Online Consultation',
      patientCount: '8/10 Patients',
      date: '05/11/2025',
      time: '7.00 PM - 9.00 PM',
      sessionType: 'Teleconsultation',
      iconColor: Color(0xFF6D28D9),
      note: 'Video Consultation Slots',
    ),
    _Session(
      hospitalName: 'Online Consultation',
      patientCount: '8/10 Patients',
      date: '05/11/2025',
      time: '7.00 PM - 9.00 PM',
      sessionType: 'Teleconsultation',
      iconColor: Color(0xFF6D28D9),
      note: 'Video Consultation Slots',
    ),
  ];

  final List<_Session> _tomorrowData = [
    _Session(
      hospitalName: 'Online Consultation',
      patientCount: '8/10 Patients',
      date: '06/11/2025',
      time: '7.00 PM - 9.00 PM',
      sessionType: 'Teleconsultation',
      iconColor: Color(0xFF6D28D9),
      note: 'Video Consultation Slots',
    ),
    _Session(
      hospitalName: 'Hemas Hospital',
      patientCount: '10/20 Patients (H001)',
      date: '06/11/2025',
      time: '5.00 PM',
      sessionType: 'Hospital',
      iconColor: Color(0xFF10B981),
      note: 'General Consultation Hours',
    ),
  ];

  // Sessions for dates beyond tomorrow
  final List<_Session> _upcomingData = [];

  void _addSessionFromForm(Map<String, dynamic> data) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = SessionUtils.parseDate(data['date']) ?? today;
    final isToday =
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
    final isTomorrow = date.difference(today).inDays == 1;

    final sessionType = (data['sessionType'] as String?) ?? 'Teleconsultation';
    final hospital = (data['hospital'] as String?) ?? 'Online Consultation';
    final maxPatients =
        int.tryParse((data['maxPatients'] ?? '').toString()) ?? 0;
    final startTime = (data['startTime'] as String?) ?? '';
    final endTime = (data['endTime'] as String?) ?? '';
    final notes = (data['notes'] as String?) ?? '';

    final displayHospital =
        sessionType == 'Teleconsultation' ? 'Online Consultation' : hospital;
    final displayTime =
        (startTime.isNotEmpty && endTime.isNotEmpty)
            ? '$startTime - $endTime'
            : (startTime.isNotEmpty ? startTime : '');
    final displayPatients = '0/${maxPatients > 0 ? maxPatients : 0} Patients';

    setState(() {
      if (isToday) {
        _todayData.insert(
          0,
          _Session(
            hospitalName: displayHospital,
            patientCount: displayPatients,
            date: SessionUtils.formatDMY(date),
            time: displayTime,
            sessionType: sessionType,
            iconColor: SessionUtils.colorForType(sessionType),
            note: notes,
          ),
        );
      } else if (isTomorrow) {
        _tomorrowData.insert(
          0,
          _Session(
            hospitalName: displayHospital,
            patientCount: displayPatients,
            date: SessionUtils.formatDMY(date),
            time: displayTime,
            sessionType: sessionType,
            iconColor: SessionUtils.colorForType(sessionType),
            note: notes,
          ),
        );
      } else {
        // Move to Upcoming (other dates) and include date in the subtitle
        final dateLabel = SessionUtils.formatDate(date);
        final composedNote =
            notes.isNotEmpty ? 'Date: $dateLabel • $notes' : 'Date: $dateLabel';
        _upcomingData.insert(
          0,
          _Session(
            hospitalName: displayHospital,
            patientCount: displayPatients,
            date: SessionUtils.formatDMY(date),
            time: displayTime,
            sessionType: sessionType,
            iconColor: SessionUtils.colorForType(sessionType),
            note: composedNote,
          ),
        );
      }
    });
  }

  _Session _buildSessionFromEdit(
    Map<String, dynamic> data,
    _Session original, {
    required bool forUpcoming,
  }) {
    final sessionType =
        (data['sessionType'] as String?) ?? original.sessionType;
    final hospital = (data['hospital'] as String?) ?? original.hospitalName;
    final maxPatients = int.tryParse((data['maxPatients'] ?? '').toString());
    final startTime = (data['startTime'] as String?) ?? '';
    final endTime = (data['endTime'] as String?) ?? '';
    final notes = (data['notes'] as String?) ?? original.note;
    final dateStr = (data['date'] as String?) ?? original.date;

    final displayHospital =
        sessionType == 'Teleconsultation' ? 'Online Consultation' : hospital;
    final displayTime =
        (startTime.isNotEmpty && endTime.isNotEmpty)
            ? '$startTime - $endTime'
            : (startTime.isNotEmpty ? startTime : original.time);
    final displayPatients =
        maxPatients != null
            ? SessionUtils.updateMaxPatientsText(
              original.patientCount,
              maxPatients,
            )
            : original.patientCount;

    final parsed = SessionUtils.parseDate(dateStr) ?? DateTime.now();
    final dateLabel = SessionUtils.formatDate(parsed);
    final composedNote =
        forUpcoming
            ? ((notes.isNotEmpty)
                ? 'Date: $dateLabel • $notes'
                : 'Date: $dateLabel')
            : notes;

    return _Session(
      hospitalName: displayHospital,
      patientCount: displayPatients,
      date: dateStr,
      time: displayTime,
      sessionType: sessionType,
      iconColor: SessionUtils.colorForType(sessionType),
      note: composedNote,
    );
  }

  void _onEditSession(_Session original, Map<String, dynamic> data) {
    final date = SessionUtils.parseDate(data['date'] as String?);
    if (date == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isToday =
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
    final isTomorrow = date.difference(today).inDays == 1;

    setState(() {
      if (_todayData.contains(original)) {
        _todayData.remove(original);
      } else if (_tomorrowData.contains(original)) {
        _tomorrowData.remove(original);
      } else if (_upcomingData.contains(original)) {
        _upcomingData.remove(original);
      }

      if (isToday) {
        _todayData.insert(
          0,
          _buildSessionFromEdit(data, original, forUpcoming: false),
        );
      } else if (isTomorrow) {
        _tomorrowData.insert(
          0,
          _buildSessionFromEdit(data, original, forUpcoming: false),
        );
      } else {
        _upcomingData.insert(
          0,
          _buildSessionFromEdit(data, original, forUpcoming: true),
        );
      }
    });
  }

  List<_Session> _applyFilter(List<_Session> list) {
    if (_selectedFilter == 'All') return list;
    return list.where((s) => s.sessionType == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    final todaySessions = _applyFilter(_todayData);
    final tomorrowSessions = _applyFilter(_tomorrowData);
    final otherUpcomingSessions = _applyFilter(_upcomingData);

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
                  onPressed: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddSessionScreen(),
                      ),
                    );
                    if (result is Map<String, dynamic>) {
                      _addSessionFromForm(result);
                    }
                  },
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
                title: 'Today - ${SessionUtils.formatDate(today)}',
                children:
                    todaySessions
                        .map(
                          (s) => ActiveSessionItem(
                            hospitalName: s.hospitalName,
                            patientCount: s.patientCount,
                            date: s.date,
                            time: s.time,
                            sessionType: s.sessionType,
                            note: s.note,
                            iconColor: s.iconColor,
                            onUpdate: (updated) => _onEditSession(s, updated),
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: 16),

              SessionSection(
                title: 'Tomorrow - ${SessionUtils.formatDate(tomorrow)}',
                children:
                    tomorrowSessions
                        .map(
                          (s) => ActiveSessionItem(
                            hospitalName: s.hospitalName,
                            patientCount: s.patientCount,
                            date: s.date,
                            time: s.time,
                            sessionType: s.sessionType,
                            note: s.note,
                            iconColor: s.iconColor,
                            onUpdate: (updated) => _onEditSession(s, updated),
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: 16),

              SessionSection(
                title: 'Upcoming Sessions',
                children:
                    otherUpcomingSessions
                        .map(
                          (s) => ActiveSessionItem(
                            hospitalName: s.hospitalName,
                            patientCount: s.patientCount,
                            date: s.date,
                            time: s.time,
                            sessionType: s.sessionType,
                            note: s.note,
                            iconColor: s.iconColor,
                            onUpdate: (updated) => _onEditSession(s, updated),
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
