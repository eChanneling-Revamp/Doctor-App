import 'package:doctorapp/screens/appointment/appointments_screen.dart';
import 'package:doctorapp/screens/home/home_screen.dart';
import 'package:doctorapp/screens/income/income_screen.dart';
import 'package:doctorapp/screens/session/session_screen.dart';
import 'package:doctorapp/screens/teleconsultation/teleconsultation_screen.dart';
import 'package:doctorapp/widgets/home_widgets/navigation_bar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return WillPopScope(
      onWillPop: () async {
        // If we're not on the home tab, go to home instead of popping the app
        if (_selectedIndex != 0) {
          setState(() => _selectedIndex = 0);
          return false; // prevent default pop
        }

        // On home tab: ask the user to confirm exit with a polished dialog
        final shouldExit =
            await showDialog<bool>(
              context: context,
              barrierDismissible: true,
              builder: (ctx) {
                final theme = Theme.of(ctx);
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 18.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          size: 48.sp,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Exit app?',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Are you sure you want to exit the app?',
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: theme.colorScheme.onSurface,
                                  side: BorderSide(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                ),
                                onPressed: () => Navigator.of(ctx).pop(false),
                                child: const Text('Cancel'),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.error,
                                  foregroundColor: theme.colorScheme.onError,
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                ),
                                onPressed: () => Navigator.of(ctx).pop(true),
                                child: const Text('Exit'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ) ??
            false;

        return shouldExit;
      },
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: HomeBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
