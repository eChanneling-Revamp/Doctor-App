import 'package:flutter/material.dart';
import '../widgets/home_widgets/appbar_widgets.dart';
import '../widgets/home_widgets/doctor_overview_widgets.dart';
import '../widgets/home_widgets/navigation_bar_widgets.dart';
import '../widgets/home_widgets/quick_actions_widgets.dart';
import '../widgets/home_widgets/schedule_buttons_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _showPatientAppointments = true; // Always show on startup
  bool _showActiveSessions = false;
  bool _showRecentPayments = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with logo and navigation
           // const HomeHeaderWidget(),
      
            // Doctor overview card
            const DoctorOverviewCard(),
      
            const SizedBox(height: 5),
      
            // Quick actions
            const QuickActionsSection(),
      
            const SizedBox(height: 15),
      
            // Schedule buttons
            ScheduleButtonsSection(
              onTodayScheduleTap: () {
                setState(() {
                  _showPatientAppointments = true;
                  _showActiveSessions = false;
                  _showRecentPayments = false;
                });
              },
              onActiveSessionsTap: () {
                setState(() {
                  _showActiveSessions = true;
                  _showPatientAppointments = false;
                  _showRecentPayments = false;
                });
              },
              onRecentPaymentsTap: () {
                setState(() {
                  _showRecentPayments = true;
                  _showPatientAppointments = false;
                  _showActiveSessions = false;
                });
              },
              isTodayScheduleActive: _showPatientAppointments,
              isActiveSessionsActive: _showActiveSessions,
              isRecentPaymentsActive: _showRecentPayments,
            ),
      
            const SizedBox(height: 15),
            const SizedBox(height: 80), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}