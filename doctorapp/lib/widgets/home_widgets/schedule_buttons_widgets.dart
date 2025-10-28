import 'package:flutter/material.dart';

class ScheduleButtonsSection extends StatelessWidget {
  final VoidCallback? onTodayScheduleTap;
  final VoidCallback? onActiveSessionsTap;
  final VoidCallback? onRecentPaymentsTap;
  final bool isTodayScheduleActive;
  final bool isActiveSessionsActive;
  final bool isRecentPaymentsActive;

  const ScheduleButtonsSection({
    super.key,
    this.onTodayScheduleTap,
    this.onActiveSessionsTap,
    this.onRecentPaymentsTap,
    this.isTodayScheduleActive = false,
    this.isActiveSessionsActive = false,
    this.isRecentPaymentsActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: _buildScheduleButton(
              'Today\'s Schedule',
              isTodayScheduleActive
                  ? const Color.fromARGB(255, 25, 113, 235)
                  : const Color.fromARGB(255, 19, 11, 169),
              Colors.white,
              onTodayScheduleTap ?? () {},
              isToday: true,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _buildScheduleButton(
              'Active Sessions',
              isActiveSessionsActive
                  ? const Color.fromARGB(255, 25, 113, 235)
                  : const Color.fromARGB(255, 19, 11, 169),
              Colors.white,
              onActiveSessionsTap ?? () {},
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _buildScheduleButton(
              'Recent Payments',
              isRecentPaymentsActive
                  ? const Color.fromARGB(255, 25, 113, 235)
                  : const Color.fromARGB(255, 19, 11, 169),
              Colors.white,
              onRecentPaymentsTap ?? () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleButton(
    String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed, {
    bool isToday = false,
  }) {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: isToday ? 12 : 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
