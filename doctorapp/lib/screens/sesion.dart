import 'package:flutter/material.dart';
import '../widgets/home_widgets/navigation_bar_widgets.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const Center(child: Text('Session screen')),
      bottomNavigationBar: const HomeBottomNavigationBar(currentIndex: 2),
    );
  }
}
