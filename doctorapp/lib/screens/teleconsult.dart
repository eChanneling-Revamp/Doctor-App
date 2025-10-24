import 'package:flutter/material.dart';
import '../widgets/home_widgets/navigation_bar_widgets.dart';

class TeleconsultScreen extends StatefulWidget {
  const TeleconsultScreen({super.key});

  @override
  State<TeleconsultScreen> createState() => _TeleconsultScreenState();
}

class _TeleconsultScreenState extends State<TeleconsultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teleconsult'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const Center(child: Text('Teleconsult screen')),
      bottomNavigationBar: const HomeBottomNavigationBar(currentIndex: 3),
    );
  }
}
