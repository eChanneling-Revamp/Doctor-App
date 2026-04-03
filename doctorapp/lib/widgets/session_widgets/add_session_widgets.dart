import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/session_service.dart';
import '../../services/auth_service.dart';
import '../../utils/snackbar_utils.dart';
import '../../utils/session_constants.dart';
import '../share_widgets/buttons.dart';
import 'session_form_fields.dart';

class AddSessionForm extends StatefulWidget {
  const AddSessionForm({super.key});

  @override
  State<AddSessionForm> createState() => _AddSessionFormState();
}

class _AddSessionFormState extends State<AddSessionForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateCtrl = TextEditingController();
  final TextEditingController _maxPatientsCtrl = TextEditingController(
    text: '20',
  );
  final TextEditingController _startTimeCtrl = TextEditingController();
  final TextEditingController _endTimeCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController(
    text: 'Video Consultation Slots',
  );

  String _sessionType = 'Teleconsultation';
  String _hospital = 'Hemas Hospital';
  bool _isLoading = false;
  String? _doctorId;

  @override
  void initState() {
    super.initState();
    _loadDoctorProfile();
  }

  Future<void> _loadDoctorProfile() async {
    try {
      final doctorId = await AuthService.getDoctorId();
      if (doctorId != null && mounted) {
        setState(() {
          _doctorId = doctorId;
        });
      } else if (mounted) {
        SnackbarUtils.error(
          context,
          'Doctor ID not found. Please login again.',
        );
      }
    } catch (e) {
      if (mounted) {
        SnackbarUtils.error(context, 'Failed to load doctor profile');
      }
    }
  }

  @override
  void dispose() {
    _dateCtrl.dispose();
    _maxPatientsCtrl.dispose();
    _startTimeCtrl.dispose();
    _endTimeCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      setState(() {
        _dateCtrl.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  Future<void> _pickTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  DateTime? _parseDateTime(String dateStr, String timeStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length != 3) return null;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      // Remove AM/PM suffix first
      String cleanTimeStr = timeStr
          .replaceAll('AM', '')
          .replaceAll('PM', '')
          .trim();

      final timeParts = cleanTimeStr.split(':');
      if (timeParts.length != 2) return null;

      int hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      // Handle AM/PM if present
      if (timeStr.contains('AM') || timeStr.contains('PM')) {
        final isPM = timeStr.contains('PM');
        if (isPM && hour != 12) {
          hour += 12;
        } else if (!isPM && hour == 12) {
          hour = 0;
        }
      }

      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      return null;
    }
  }

  Future<void> _createSession() async {
    if (_formKey.currentState?.validate() != true) {
      SnackbarUtils.error(context, 'Please fill in all required fields');
      return;
    }

    if (_doctorId == null) {
      SnackbarUtils.error(
        context,
        'Doctor profile not loaded. Please try again.',
      );
      return;
    }

    final startDateTime = _parseDateTime(_dateCtrl.text, _startTimeCtrl.text);
    final endDateTime = _parseDateTime(_dateCtrl.text, _endTimeCtrl.text);

    if (startDateTime == null || endDateTime == null) {
      SnackbarUtils.error(context, 'Invalid date or time format');
      return;
    }

    if (startDateTime.isAfter(endDateTime)) {
      SnackbarUtils.error(context, 'Start time must be before end time');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final hospitalId = getHospitalId(_hospital);
      final nurseId = getNurseId('Default Nurse');

      final session = await SessionService.createSession(
        doctorId: _doctorId!,
        hospitalId: hospitalId,
        nurseId: nurseId,
        hospitalName: _hospital,
        patientCapacity: int.parse(_maxPatientsCtrl.text),
        startTime: startDateTime,
        endTime: endDateTime,
        sessionType: _sessionType,
        location: _sessionType == 'Teleconsultation' ? 'Online' : _hospital,
        notes: _notesCtrl.text,
      );

      if (mounted) {
        SnackbarUtils.success(context, 'Session created successfully');
        Navigator.pop(context, {
          'success': true,
          'session': session,
          'sessionType': _sessionType,
          'hospital': _hospital,
          'date': _dateCtrl.text,
          'maxPatients': _maxPatientsCtrl.text,
          'startTime': _startTimeCtrl.text,
          'endTime': _endTimeCtrl.text,
          'notes': _notesCtrl.text,
        });
      }
    } catch (e) {
      if (mounted) {
        SnackbarUtils.error(context, 'Error: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SessionFormFields(
            sessionType: _sessionType,
            hospital: _hospital,
            onSessionTypeChanged: (v) =>
                setState(() => _sessionType = v ?? _sessionType),
            onHospitalChanged: (v) =>
                setState(() => _hospital = v ?? _hospital),
            dateController: _dateCtrl,
            maxPatientsController: _maxPatientsCtrl,
            startTimeController: _startTimeCtrl,
            endTimeController: _endTimeCtrl,
            notesController: _notesCtrl,
            onPickDate: _pickDate,
            onPickTime: (c) async => _pickTime(c),
          ),
          SizedBox(height: 16.h),
          CustomButton(
            text: _isLoading ? 'Creating Session...' : 'Create Session',
            onPressed: _isLoading ? () {} : _createSession,
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
