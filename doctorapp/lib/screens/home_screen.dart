import 'package:flutter/material.dart';
import '../widgets/home_widgets/appbar_widgets.dart';
import '../widgets/home_widgets/doctor_overview_widgets.dart';
import '../widgets/home_widgets/navigation_bar_widgets.dart';
import '../widgets/home_widgets/quick_actions_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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