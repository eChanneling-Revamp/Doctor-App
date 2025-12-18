import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'stat_card.dart';
import 'time_slot_card.dart';

class DailyView extends StatelessWidget {
  final List<Map<String, dynamic>> timeSlots;

  const DailyView({super.key, required this.timeSlots});

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
                    value: '18',
                    label: 'Total Slots',
                    color: const Color.fromARGB(255, 62, 100, 206),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: StatCard(
                    value: '12',
                    label: 'Booked',
                    color: const Color.fromARGB(255, 62, 100, 206),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: StatCard(
                    value: '6',
                    label: 'Available',
                    color: const Color.fromARGB(255, 62, 100, 206),
                  ),
                ),
              ],
            ),
          ),
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
