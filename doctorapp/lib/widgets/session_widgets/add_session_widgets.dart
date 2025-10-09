import 'package:flutter/material.dart';
import '../shared_widgets.dart';
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
            onSessionTypeChanged:
                (v) => setState(() => _sessionType = v ?? _sessionType),
            onHospitalChanged:
                (v) => setState(() => _hospital = v ?? _hospital),
            dateController: _dateCtrl,
            maxPatientsController: _maxPatientsCtrl,
            startTimeController: _startTimeCtrl,
            endTimeController: _endTimeCtrl,
            notesController: _notesCtrl,
            onPickDate: _pickDate,
            onPickTime: (c) async => _pickTime(c),
          ),

          CustomButton(
            text: 'Create Session',
            onPressed: () {
              if (_formKey.currentState?.validate() ?? true) {
                Navigator.pop(context);
              }
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
