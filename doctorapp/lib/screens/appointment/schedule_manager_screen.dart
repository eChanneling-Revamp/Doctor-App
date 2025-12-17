import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../utils/snackbar_utils.dart';
import '../../widgets/appointment_widgets/schedule_widgets/location_selector.dart';
import '../../widgets/appointment_widgets/schedule_widgets/view_toggle.dart';
import '../../widgets/appointment_widgets/schedule_widgets/daily_view.dart';
import '../../widgets/appointment_widgets/schedule_widgets/week_view.dart';
import '../../widgets/appointment_widgets/schedule_widgets/schedule_edit_widgets/schedule_edit_dialog.dart';

class ScheduleManagerScreen extends StatefulWidget {
  const ScheduleManagerScreen({super.key});

  @override
  State<ScheduleManagerScreen> createState() => _ScheduleManagerScreenState();
}

class _ScheduleManagerScreenState extends State<ScheduleManagerScreen> {
  bool _isDailyView = false;
  String _selectedLocation = 'Hemas Hospital';
  DateTime _selectedDate = DateTime(2025, 10, 15);

  final List<String> _locations = [
    'Hemas Hospital',
    'Asiri Hospital',
    'Nawaloka Hospital',
  ];

  final List<Map<String, dynamic>> _timeSlots = [
    {'time': '09.00 AM', 'patient': null},
    {'time': '09.30 AM', 'patient': null},
    {'time': '10.00 AM', 'patient': 'John Doe'},
    {'time': '10.30 AM', 'patient': null},
    {'time': '11.00 AM', 'patient': null},
    {'time': '11.30 AM', 'patient': null},
    {'time': '03.00 PM', 'patient': null},
    {'time': '03.30 PM', 'patient': 'Ann Perera'},
    {'time': '04.00 PM', 'patient': null},
    {'time': '04.30 PM', 'patient': null},
    {'time': '05.00 PM', 'patient': 'Tae Kim'},
    {'time': '05.30 PM', 'patient': 'Elee Silva'},
    {'time': '06.00 PM', 'patient': null},
    {'time': '06.30 PM', 'patient': null},
    {'time': '07.00 PM', 'patient': 'Jhope Dee'},
    {'time': '07.30 PM', 'patient': null},
    {'time': '08.00 PM', 'patient': null},
    {'time': '08.30 PM', 'patient': null},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const CustomBackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schedule Manager',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Manage Availability & Booking',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.r),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 120.w),
              child: CustomButton(
                text: 'Edit',
                onPressed: _showEditScheduleDialog,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                height: 36.h,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Location Dropdown
            LocationSelector(
              selectedLocation: _selectedLocation,
              locations: _locations,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                  SnackbarUtils.info(context, 'Location changed to $newValue');
                }
              },
            ),
            // View Toggle
            ViewToggle(
              isDailyView: _isDailyView,
              onViewChanged: (bool isDailyView) {
                setState(() {
                  _isDailyView = isDailyView;
                });
              },
            ),
            // Content
            Expanded(
              child: _isDailyView
                  ? DailyView(timeSlots: _timeSlots)
                  : WeekView(
                      timeSlots: _timeSlots,
                      selectedDate: _selectedDate,
                      onPreviousWeek: () {
                        setState(() {
                          _selectedDate = _selectedDate.subtract(
                            const Duration(days: 7),
                          );
                        });
                      },
                      onNextWeek: () {
                        setState(() {
                          _selectedDate = _selectedDate.add(
                            const Duration(days: 7),
                          );
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditScheduleDialog() {
    SnackbarUtils.info(context, 'Opening schedule editor');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ScheduleEditDialog();
      },
    );
  }
}
