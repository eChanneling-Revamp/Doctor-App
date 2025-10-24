import 'package:flutter/material.dart';
import '../../../utils/snackbar_utils.dart';
import '../../shared_widgets.dart';

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
              const Center(
                child: Text(
                  'Schedule Edit',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildLocationDropdown(),
              const SizedBox(height: 10),
              _buildWorkingDaysSection(),
              const SizedBox(height: 10),
              _buildTimeSelection(),
              const SizedBox(height: 20),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hospital / Location',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            value: _selectedLocation,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down, size: 24),
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            items:
                _locations.map((String location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLocation = newValue;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingDaysSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Working Days',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        ..._workingDays.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 15,
                      color: entry.value ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: entry.value,
                      onChanged: (bool value) {
                        setState(() {
                          _workingDays[entry.key] = value;
                        });
                      },
                      activeColor: const Color(0xFF4CAF50),
                      inactiveThumbColor: Colors.grey.shade400,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTimeSelection() {
    return Row(
      children: [
        Expanded(
          child: _buildTimePicker(
            label: 'Start Time',
            time: _startTime,
            onTimePicked: (picked) {
              setState(() {
                _startTime = picked;
              });
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildTimePicker(
            label: 'End Time',
            time: _endTime,
            onTimePicked: (picked) {
              setState(() {
                _endTime = picked;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker({
    required String label,
    required TimeOfDay time,
    required ValueChanged<TimeOfDay> onTimePicked,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: time,
            );
            if (picked != null) {
              onTimePicked(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                time.format(context),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Update',
            onPressed: () {
              Navigator.pop(context);
              SnackbarUtils.success(context, 'Schedule updated successfully');
            },
            backgroundColor: const Color(0xFF3D1DE1),
            height: 54,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SecondaryButton(
            text: 'Cancel',
            onPressed: () {
              Navigator.pop(context);
            },
            height: 54,
          ),
        ),
      ],
    );
  }
}
