import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/session_widgets/active_session.dart';
import '../home/add_session_screen.dart';
import '../../widgets/session_widgets/session_filter_row.dart';
import '../../widgets/session_widgets/session_section.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../utils/date_time_utils.dart';
import '../../utils/snackbar_utils.dart';

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

  /// Returns a color for the session type.
  static Color colorForType(String type) =>
      type == 'Hospital' ? const Color(0xFF10B981) : const Color(0xFF6D28D9);

  /// Updates the max patients text keeping the current prefix.
  ///
  /// Example: `10/20 Patients` with `newMax=30` => `10/30 Patients`.
  static String updateMaxPatientsText(String current, int newMax) {
    return current.replaceFirst(RegExp(r"/(\d+)"), '/$newMax');
  }

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
    final today = DateTimeUtils.getToday();
    final date = DateTimeUtils.parseDate(data['date']) ?? today;
    final isToday = DateTimeUtils.isToday(date);
    final isTomorrow = DateTimeUtils.isTomorrow(date);

    final sessionType = (data['sessionType'] as String?) ?? 'Teleconsultation';
    final hospital = (data['hospital'] as String?) ?? 'Online Consultation';
    final maxPatients =
        int.tryParse((data['maxPatients'] ?? '').toString()) ?? 0;
    final startTime = (data['startTime'] as String?) ?? '';
    final endTime = (data['endTime'] as String?) ?? '';
    final notes = (data['notes'] as String?) ?? '';

    final displayHospital = sessionType == 'Teleconsultation'
        ? 'Online Consultation'
        : hospital;
    final displayTime = (startTime.isNotEmpty && endTime.isNotEmpty)
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
            date: DateTimeUtils.formatDMY(date),
            time: displayTime,
            sessionType: sessionType,
            iconColor: colorForType(sessionType),
            note: notes,
          ),
        );
      } else if (isTomorrow) {
        _tomorrowData.insert(
          0,
          _Session(
            hospitalName: displayHospital,
            patientCount: displayPatients,
            date: DateTimeUtils.formatDMY(date),
            time: displayTime,
            sessionType: sessionType,
            iconColor: colorForType(sessionType),
            note: notes,
          ),
        );
      } else {
        // Move to Upcoming (other dates) and include date in the subtitle
        final dateLabel = DateTimeUtils.formatDate(date);
        final composedNote = notes.isNotEmpty
            ? 'Date: $dateLabel • $notes'
            : 'Date: $dateLabel';
        _upcomingData.insert(
          0,
          _Session(
            hospitalName: displayHospital,
            patientCount: displayPatients,
            date: DateTimeUtils.formatDMY(date),
            time: displayTime,
            sessionType: sessionType,
            iconColor: colorForType(sessionType),
            note: composedNote,
          ),
        );
      }
    });
    SnackbarUtils.success(context, 'Session added successfully');
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

    final displayHospital = sessionType == 'Teleconsultation'
        ? 'Online Consultation'
        : hospital;
    final displayTime = (startTime.isNotEmpty && endTime.isNotEmpty)
        ? '$startTime - $endTime'
        : (startTime.isNotEmpty ? startTime : original.time);
    final displayPatients = maxPatients != null
        ? updateMaxPatientsText(original.patientCount, maxPatients)
        : original.patientCount;

    final parsed = DateTimeUtils.parseDate(dateStr) ?? DateTime.now();
    final dateLabel = DateTimeUtils.formatDate(parsed);
    final composedNote = forUpcoming
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
      iconColor: colorForType(sessionType),
      note: composedNote,
    );
  }

  void _onEditSession(_Session original, Map<String, dynamic> data) {
    final date = DateTimeUtils.parseDate(data['date'] as String?);
    if (date == null) return;

    final isToday = DateTimeUtils.isToday(date);
    final isTomorrow = DateTimeUtils.isTomorrow(date);

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
    SnackbarUtils.success(context, 'Session updated successfully');
  }

  List<_Session> _applyFilter(List<_Session> list) {
    if (_selectedFilter == 'All') return list;
    return list.where((s) => s.sessionType == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTimeUtils.getToday();
    final tomorrow = DateTimeUtils.getTomorrow();
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
        title: Text(
          'Session Management',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.r),
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
                    } else if (result == null) {
                      SnackbarUtils.info(context, 'Session creation cancelled');
                    }
                  },
                  borderColor: const Color(0xFF4A3FFF),
                  textColor: const Color(0xFF4A3FFF),
                  height: 40.h,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),

                // Filter row (extracted widget)
                SessionFilterRow(
                  selectedFilter: _selectedFilter,
                  activeFilterCount: activeFilterCount,
                  onSelected: (value) =>
                      setState(() => _selectedFilter = value),
                ),

                SizedBox(height: 16.h),

                SessionSection(
                  title: 'Today - ${DateTimeUtils.formatDate(today)}',
                  children: todaySessions
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

                SizedBox(height: 16.h),

                SessionSection(
                  title: 'Tomorrow - ${DateTimeUtils.formatDate(tomorrow)}',
                  children: tomorrowSessions
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

                SizedBox(height: 16.h),

                SessionSection(
                  title: 'Upcoming Sessions',
                  children: otherUpcomingSessions
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

                SizedBox(height: 48.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
