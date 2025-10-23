import 'package:flutter/material.dart';

class TimeSlotCard extends StatelessWidget {
  final String time;
  final String? patient;

  const TimeSlotCard({super.key, required this.time, this.patient});

  @override
  Widget build(BuildContext context) {
    final isBooked = patient != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      decoration: BoxDecoration(
        color: isBooked ? const Color(0xFF4CAF50) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isBooked ? const Color(0xFF4CAF50) : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isBooked ? Colors.white : Colors.black87,
            ),
          ),
          if (isBooked) ...[
            const SizedBox(height: 2),
            Text(
              patient!,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
