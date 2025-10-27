import 'package:flutter/material.dart';

import 'schedule_edit_header.dart';
import 'location_dropdown_widget.dart';
import 'working_days_widget.dart';
import 'time_picker_field.dart';
import 'schedule_action_buttons.dart';

class ScheduleEditDialog extends StatefulWidget {
  const ScheduleEditDialog({super.key});

  @override
  State<ScheduleEditDialog> createState() => _ScheduleEditDialogState();
}

class _ScheduleEditDialogState extends State<ScheduleEditDialog> {
  String _selectedLocation = 'Hemas Hospital';
  final Map<String, bool> _workingDays = {
    'Monday': true,
    'Tuesday': false,
    'Wednesday': true,
    'Thursday': false,
    'Friday': true,
    'Saturday': true,
    'Sunday': false,
  };
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 20, minute: 30);

  final List<String> _locations = [
    'Hemas Hospital',
    'Asiri Hospital',
    'Nawaloka Hospital',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScheduleEditHeader(),
              const SizedBox(height: 10),
              LocationDropdown(
                selectedLocation: _selectedLocation,
                locations: _locations,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedLocation = val);
                },
              ),
              const SizedBox(height: 10),
              WorkingDaysWidget(
                workingDays: _workingDays,
                onToggle:
                    (day, value) => setState(() => _workingDays[day] = value),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TimePickerField(
                      label: 'Start Time',
                      time: _startTime,
                      onTimePicked:
                          (picked) => setState(() => _startTime = picked),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TimePickerField(
                      label: 'End Time',
                      time: _endTime,
                      onTimePicked:
                          (picked) => setState(() => _endTime = picked),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ScheduleActionButtons(
                onUpdate: () => Navigator.pop(context),
                onCancel: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
