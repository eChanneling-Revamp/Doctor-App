import 'package:flutter/material.dart';

class ConsultationCard extends StatelessWidget {
  final Map<String, dynamic> consultation;
  final VoidCallback? onStart;

  const ConsultationCard({super.key, required this.consultation, this.onStart});

  @override
  Widget build(BuildContext context) {
    final bool isConfirmed = consultation['isConfirmed'] as bool;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9ECEF), width: 1),
      ),
      child: Row(
        children: [
          // Video Icon
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF6D28D9).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.videocam,
              color: Color(0xFF6D28D9),
              size: 26,
            ),
          ),
          const SizedBox(width: 10),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      consultation['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isConfirmed
                                ? const Color(0xFF10B981).withOpacity(0.1)
                                : const Color(0xFFF59E0B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isConfirmed ? 'Confirmed' : 'Pending',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color:
                              isConfirmed
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      consultation['time'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  consultation['day'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          // Action: Start icon
          if (onStart != null)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: onStart,
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFF10B981),
                  size: 22,
                ),
                padding: EdgeInsets.zero,
                tooltip: 'Start consultation',
              ),
            ),
        ],
      ),
    );
  }
}
