import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        SizedBox(height: 6.h),
        Text(
          'Session Type',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),

        SizedBox(height: 16.h),
        Text(
          'Hospital / Location',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),

        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: onPickDate,
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hintText: 'DD/MM/YYYY',
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        validator: (v) {
                          final value = (v ?? '').trim();
                          if (value.isEmpty) return 'Date is required';
                          final parts = value.split('/');
                          if (parts.length != 3) return 'Use DD/MM/YYYY';
                          final d = int.tryParse(parts[0]);
                          final m = int.tryParse(parts[1]);
                          final y = int.tryParse(parts[2]);
                          if (d == null || m == null || y == null) {
                            return 'Invalid date';
                          }
                          if (m < 1 || m > 12 || d < 1 || d > 31) {
                            return 'Invalid date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Max Patients',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8.h),
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

        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Time',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8.h),
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
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End Time',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8.h),
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

        SizedBox(height: 16.h),
        Text('Notes', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        CustomTextField(
          hintText: 'Video Consultation Slots',
          controller: notesController,
        ),

        SizedBox(height: 14.h),
        Text(
          'Current: 12/${maxPatientsController.text} Patients Booked',
          style: TextStyle(fontSize: 13.sp, color: Colors.green),
        ),

        SizedBox(height: 24.h),
      ],
    );
  }
}
