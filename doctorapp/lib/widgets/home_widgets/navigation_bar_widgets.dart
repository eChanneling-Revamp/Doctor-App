import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/appointment/appointments_screen.dart';
import '../../screens/session/session_screen.dart';
import '../../screens/teleconsultation/teleconsultation_screen.dart';
import '../../screens/income/income_screen.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const HomeBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        // Prefer custom handler if provided
        if (onTap != null) {
          onTap!(index);
          return;
        }

        // Default navigation behaviour: avoid navigating to same index
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AppointmentsScreen()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SessionScreen()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const TeleconsultScreen()),
            );
            break;
          case 4:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const IncomeScreen()),
            );
            break;
          default:
            break;
        }
      },
      selectedItemColor: const Color(0xFF4A3FFF),
      unselectedItemColor: Colors.grey.shade600,
      backgroundColor: Colors.white,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Appointment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          label: 'Session',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_call),
          label: 'Teleconsult',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Income',
        ),
      ],
    );
  }
}
