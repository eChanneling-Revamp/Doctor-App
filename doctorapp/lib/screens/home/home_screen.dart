import 'package:flutter/material.dart';
import '../../widgets/home_widgets/active_session.dart';
import '../../widgets/home_widgets/appbar_widgets.dart';
import '../../widgets/home_widgets/doctor_overview_widgets.dart';
import '../../widgets/home_widgets/patient_appointment_widgets.dart';
import '../../widgets/home_widgets/payment_widgets.dart';
import '../../widgets/home_widgets/quick_actions_widgets.dart';
import '../../widgets/home_widgets/schedule_buttons_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showPatientAppointments = true; // Always show on startup
  bool _showActiveSessions = false;
  bool _showRecentPayments = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            // Appointments list - conditionally shown
            if (_showPatientAppointments) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Today's Appointments",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const PatientAppointmentItem(
                patientName: 'Mary De Silva',
                appointmentType: 'Teleconsult',
                time: '10:30am - 11:30am',
                avatarAsset: 'assets/images/avatar1.png',
                isConfirmed: true,
              ),
              const PatientAppointmentItem(
                patientName: 'Henry Gamage',
                appointmentType: 'In Person',
                time: '11:30am - 12:30pm',
                avatarAsset: 'assets/images/avatar2.png',
                isConfirmed: true,
              ),
              const PatientAppointmentItem(
                patientName: 'Agnes Liyanage',
                appointmentType: 'In Person',
                time: '14:30pm - 15:30pm',
                avatarAsset: 'assets/images/avatar3.png',
                isConfirmed: true,
              ),
            ],

            // Active Sessions - conditionally shown
            if (_showActiveSessions) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Active Sessions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const ActiveSessionItem(
                hospitalName: 'Hemas Hospital',
                patientCount: '10/20 Patients (H001)',
                time: '5.00 PM',
                sessionType: 'General Consultation Hours',
                iconColor: Colors.green,
              ),
              const ActiveSessionItem(
                hospitalName: 'Online Consultation',
                patientCount: '8/10 Patients',
                time: '7.00 PM - 9.00 PM',
                sessionType: 'Video Consultation Slots',
                iconColor: Colors.purple,
              ),
              const ActiveSessionItem(
                hospitalName: 'Ninewells Hospital',
                patientCount: '14/15 Patients (NW108)',
                time: '10.00 AM',
                sessionType: 'General Consultation Hours',
                iconColor: Colors.green,
              ),
            ],

            // Recent Payments - conditionally shown
            if (_showRecentPayments) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Recent Payments",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const PaymentItem(
                hospitalName: 'Hemas Hospital',
                consultationType: 'General Consultation',
                time: '4:00 PM',
                amount: 'LKR 20,000',
                isPaid: true,
              ),
              const PaymentItem(
                hospitalName: 'Healan Hospital Homagama',
                consultationType: 'Video Consultation',
                time: '23:00 PM',
                amount: 'LKR 12,000',
                isPaid: false,
              ),
              const PaymentItem(
                hospitalName: 'Ninewells Hospital',
                consultationType: 'General Consultation',
                time: '10:00 AM',
                amount: 'LKR 60,000',
                isPaid: true,
              ),
            ],

            const SizedBox(height: 80), // Space for bottom navigation
          ],
        ),
      ),
    );
  }
}