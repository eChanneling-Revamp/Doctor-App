import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/appointment_widgets/appointment_tab_bar.dart';
import '../../widgets/appointment_widgets/appointment_list_view.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../utils/snackbar_utils.dart';
import 'schedule_manager_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  // Sample data for appointments
  final List<Map<String, dynamic>> _currentAppointments = [
    {
      'name': 'Mary De Silva',
      'type': 'Teleconsult',
      'time': '10:30am - 11:30am',
      'isConfirmed': true,
      'initials': 'MD',
    },
    {
      'name': 'Henry Gamage',
      'type': 'In Person',
      'time': '11:30am - 12:30pm',
      'isConfirmed': true,
      'initials': 'HG',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': false,
      'initials': 'AL',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': true,
      'initials': 'AL',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': false,
      'initials': 'AL',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': true,
      'initials': 'AL',
    },
  ];

  final List<Map<String, dynamic>> _upcomingAppointments = [
    {
      'name': 'Mary De Silva',
      'type': 'Teleconsult',
      'time': '10:30am - 11:30am',
      'isConfirmed': true,
      'initials': 'MD',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': false,
      'initials': 'AL',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': true,
      'initials': 'AL',
    },
  ];

  final List<Map<String, dynamic>> _pastAppointments = [
    {
      'name': 'Mary De Silva',
      'type': 'Teleconsult',
      'time': '10:30am - 11:30am',
      'isConfirmed': true,
      'initials': 'MD',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': false,
      'initials': 'AL',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': true,
      'initials': 'AL',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': true,
      'initials': 'AL',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': true,
      'initials': 'AL',
    },
    {
      'name': 'Agnes Liyanage',
      'type': 'In Person',
      'time': '14:30pm - 15:30pm',
      'isConfirmed': true,
      'initials': 'AL',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Appointments',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CustomOutlinedButton(
              text: 'Schedule',
              onPressed: () {
                SnackbarUtils.info(context, 'Opening schedule manager');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScheduleManagerScreen(),
                  ),
                );
              },
              height: 40.h,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tab Bar
            AppointmentTabBar(
              currentTabIndex: _currentTabIndex,
              onTabChanged: (index) {
                _tabController.animateTo(index);
              },
            ),
            Divider(height: 1.h),
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AppointmentListView(appointments: _currentAppointments),
                  AppointmentListView(appointments: _upcomingAppointments),
                  AppointmentListView(appointments: _pastAppointments),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
