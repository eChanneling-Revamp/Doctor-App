import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'stat_card.dart';
import 'time_slot_card.dart';
import 'date_navigator.dart';

class WeekView extends StatelessWidget {
  final List<Map<String, dynamic>> timeSlots;
  final DateTime selectedDate;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  const WeekView({
    super.key,
    required this.timeSlots,
    required this.selectedDate,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Stats
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Expanded(
                  child: StatCard(
                    value: '60',
                    label: 'Total Slots',
                    color: const Color.fromARGB(255, 62, 100, 206),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: StatCard(
                    value: '10',
                    label: 'Booked',
                    color: const Color.fromARGB(255, 62, 100, 206),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: StatCard(
                    value: '50',
                    label: 'Available',
                    color: const Color.fromARGB(255, 62, 100, 206),
                  ),
                ),
              ],
            ),
          ),
          // Date Navigator
          DateNavigator(
            selectedDate: selectedDate,
            onPrevious: onPreviousWeek,
            onNext: onNextWeek,
          ),
          SizedBox(height: 16.h),
          // Time Slots Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.r),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 14.r,
                mainAxisSpacing: 14.r,
                childAspectRatio: 2,
              ),
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                final slot = timeSlots[index];
                return TimeSlotCard(
                  time: slot['time'],
                  patient: slot['patient'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
