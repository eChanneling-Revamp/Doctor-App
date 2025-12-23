import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../screens/home/add_session_screen.dart';
import '../../screens/home/prescription_screen.dart';
import '../../screens/home/reminders_screen.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickActionItem(
                icon: Icons.description_outlined,
                label: 'Create\nPrescription',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePrescriptionScreen(),
                    ),
                  );
                },
              ),
              _buildQuickActionItem(
                icon: Icons.add_circle_outline,
                label: 'Add\nSession',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddSessionScreen(),
                    ),
                  );
                },
              ),
              _buildQuickActionItem(
                icon: Icons.assignment_outlined,
                label: 'Reminders\nManager',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RemindersScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 115.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color.fromARGB(255, 25, 113, 235)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24.r, color: const Color(0xFF4A3FFF)),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
