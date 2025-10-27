import 'package:flutter/material.dart';
import '../shared_widgets.dart';
import 'session_form_fields.dart';

class EditSessionModal extends StatefulWidget {
  final String hospitalName;
  final String patientCount;
  final String time;
  final String sessionType;
  final String note;

  const EditSessionModal({
    super.key,
    required this.hospitalName,
    required this.patientCount,
    required this.time,
    required this.sessionType,
    required this.note,
  });

  @override
  State<EditSessionModal> createState() => _EditSessionModalState();
}

class _EditSessionModalState extends State<EditSessionModal> {
  String selectedSessionType = 'Teleconsultation';
  String selectedHospital = 'Hemas Hospital';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController maxPatientsController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedHospital = widget.hospitalName;
    // If the caller provided a high-level sessionType, use it; otherwise infer
    if (widget.sessionType.isNotEmpty) {
      selectedSessionType = widget.sessionType;
    } else {
      final noteLower = widget.note.toLowerCase();
      if (noteLower.contains('video') || noteLower.contains('tele')) {
        selectedSessionType = 'Teleconsultation';
      } else if (noteLower.contains('general') ||
          noteLower.contains('consult') ||
          noteLower.contains('hospital')) {
        selectedSessionType = 'Hospital';
      } else if (noteLower.contains('walk')) {
        selectedSessionType = 'Walk-in';
      } else if (noteLower.contains('home')) {
        selectedSessionType = 'Home Visit';
      } else {
        selectedSessionType =
            widget.hospitalName.toLowerCase().contains('online')
                ? 'Teleconsultation'
                : 'Hospital';
      }
    }

    // Initialize controllers from passed values when possible
    // Date: leave blank or set a sensible placeholder
    dateController.text = '';

    // Try to extract max patients from the passed patientCount string
    final slashMatch = RegExp(r"/(\d+)").firstMatch(widget.patientCount);
    if (slashMatch != null) {
      maxPatientsController.text = slashMatch.group(1)!;
    } else {
      // fallback: pick the last number in the string
      final allNums = RegExp(r"(\d+)").allMatches(widget.patientCount);
      if (allNums.isNotEmpty) {
        maxPatientsController.text = allNums.last.group(1)!;
      } else {
        maxPatientsController.text = '20';
      }
    }

    // Parse start/end time from the passed time string if possible
    if (widget.time.contains('-')) {
      final parts = widget.time.split('-');
      startTimeController.text = parts.first.trim();
      endTimeController.text = parts.sublist(1).join('-').trim();
    } else if (widget.time.contains('to')) {
      final parts = widget.time.split('to');
      startTimeController.text = parts.first.trim();
      endTimeController.text = parts.sublist(1).join('to').trim();
    } else {
      startTimeController.text = widget.time;
      endTimeController.text = widget.time;
    }

    // Keep the note text (more specific description) intact
    notesController.text = widget.note;
  }

  @override
  void dispose() {
    dateController.dispose();
    maxPatientsController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    notesController.dispose();
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
        dateController.text =
            '${picked.day.toString().padLeft(2, "0")}/${picked.month.toString().padLeft(2, "0")}/${picked.year}';
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
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Center(
                    child: Text(
                      'Edit Session',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),

                  SessionFormFields(
                    sessionType: selectedSessionType,
                    hospital: selectedHospital,
                    onSessionTypeChanged:
                        (v) => setState(
                          () => selectedSessionType = v ?? selectedSessionType,
                        ),
                    onHospitalChanged:
                        (v) => setState(
                          () => selectedHospital = v ?? selectedHospital,
                        ),
                    dateController: dateController,
                    maxPatientsController: maxPatientsController,
                    startTimeController: startTimeController,
                    endTimeController: endTimeController,
                    notesController: notesController,
                    onPickDate: _pickDate,
                    onPickTime: (c) async => _pickTime(c),
                  ),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Update',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? true) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xFF374151),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
