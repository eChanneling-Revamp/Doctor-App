import 'package:flutter/material.dart';

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
        if (onTap != null) {
          onTap!(index);
          return;
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
