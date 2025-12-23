import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/session_widgets/active_session.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor overview card
              const DoctorOverviewCard(),

              SizedBox(height: 5.h),

              // Quick actions
              const QuickActionsSection(),

              SizedBox(height: 15.h),

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

              SizedBox(height: 15.h),

              // Appointments list - conditionally shown
              if (_showPatientAppointments) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  child: Text(
                    "Today's Appointments",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  child: Text(
                    "Active Sessions",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                const ActiveSessionItem(
                  hospitalName: 'Hemas Hospital',
                  patientCount: '10/20 Patients (H001)',
                  date: '10/09/2024',
                  time: '5.00 PM',
                  sessionType: 'Hospital',
                  note: 'General Consultation Hours',
                  iconColor: Colors.green,
                ),
                const ActiveSessionItem(
                  hospitalName: 'Online Consultation',
                  patientCount: '8/10 Patients',
                  date: '12/09/2024',
                  time: '7.00 PM - 9.00 PM',
                  sessionType: 'Teleconsultation',
                  note: 'Video Consultation Slots',
                  iconColor: Colors.purple,
                ),
                const ActiveSessionItem(
                  hospitalName: 'Ninewells Hospital',
                  patientCount: '14/15 Patients (NW108)',
                  date: '15/09/2024',
                  time: '10.00 AM',
                  sessionType: 'Hospital',
                  note: 'Pediatric Consultation Hours',
                  iconColor: Colors.green,
                ),
              ],

              // Recent Payments - conditionally shown
              if (_showRecentPayments) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  child: Text(
                    "Recent Payments",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
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

              SizedBox(height: 80.h), // Space for bottom navigation
            ],
          ),
        ),
      ),
    );
  }
}
