import 'package:doctorapp/screens/appointment/appointments_screen.dart';
import 'package:doctorapp/screens/home/home_screen.dart';
import 'package:doctorapp/screens/income/income_screen.dart';
import 'package:doctorapp/screens/session/session_screen.dart';
import 'package:doctorapp/screens/teleconsultation/teleconsultation_screen.dart';
import 'package:doctorapp/widgets/home_widgets/navigation_bar_widgets.dart';
import 'package:flutter/material.dart';

class DoctorMainApp extends StatefulWidget {
  const DoctorMainApp({super.key});

  @override
  State<DoctorMainApp> createState() => _DoctorMainAppState();
}

class _DoctorMainAppState extends State<DoctorMainApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    AppointmentsScreen(),
    SessionScreen(),
    TeleconsultScreen(),
    IncomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: HomeBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
