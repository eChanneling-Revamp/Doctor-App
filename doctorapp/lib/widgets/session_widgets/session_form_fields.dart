import 'package:flutter/material.dart';
import '../share_widgets/inputs.dart';
class SessionFormFields extends StatelessWidget {
  final String sessionType;
  final String hospital;
  final ValueChanged<String?> onSessionTypeChanged;
  final ValueChanged<String?> onHospitalChanged;

  final TextEditingController dateController;
  final TextEditingController maxPatientsController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final TextEditingController notesController;

  final Future<void> Function()? onPickDate;
  final Future<void> Function(TextEditingController)? onPickTime;

  const SessionFormFields({
    super.key,
    required this.sessionType,
    required this.hospital,
    required this.onSessionTypeChanged,
    required this.onHospitalChanged,
    required this.dateController,
    required this.maxPatientsController,
    required this.startTimeController,
    required this.endTimeController,
    required this.notesController,
    this.onPickDate,
    this.onPickTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        const Text(
          'Session Type',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: sessionType,
          items: const [
            DropdownMenuItem(
              value: 'Teleconsultation',
              child: Text('Teleconsultation'),
            ),
            DropdownMenuItem(value: 'Hospital', child: Text('Hospital')),
          ],
          onChanged: onSessionTypeChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),

        const SizedBox(height: 16),
        const Text(
          'Hospital / Location',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: hospital,
          items: const [
            DropdownMenuItem(
              value: 'Hemas Hospital',
              child: Text('Hemas Hospital'),
            ),
            DropdownMenuItem(value: 'City Clinic', child: Text('City Clinic')),
            DropdownMenuItem(
              value: 'Ninewells Hospital',
              child: Text('Ninewells Hospital'),
            ),
            DropdownMenuItem(
              value: 'Online Consultation',
              child: Text('Online Consultation'),
            ),
          ],
          onChanged: onHospitalChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),

        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: onPickDate,
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hintText: 'DD/MM/YYYY',
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Max Patients',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: '20',
                    controller: maxPatientsController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Start Time',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => onPickTime?.call(startTimeController),
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hintText: '00:00',
                        controller: startTimeController,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'End Time',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => onPickTime?.call(endTimeController),
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hintText: '00:00',
                        controller: endTimeController,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        const Text('Notes', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'Video Consultation Slots',
          controller: notesController,
        ),

        const SizedBox(height: 14),
        Text(
          'Current: 12/${maxPatientsController.text} Patients Booked',
          style: const TextStyle(color: Colors.green),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
