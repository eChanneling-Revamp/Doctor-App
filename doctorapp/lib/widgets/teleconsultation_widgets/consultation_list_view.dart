import 'package:flutter/material.dart';
import 'consultation_card.dart';

class ConsultationListView extends StatelessWidget {
  final List<Map<String, dynamic>> consultations;
  final Function(Map<String, dynamic>)? onStart;
  final String emptyText;

  const ConsultationListView({
    super.key,
    required this.consultations,
    this.onStart,
    this.emptyText = 'No upcoming teleconsultations',
  });

  @override
  Widget build(BuildContext context) {
    if (consultations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            emptyText,
            style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      children:
          consultations
              .map(
                (consultation) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ConsultationCard(
                    consultation: consultation,
                    onStart:
                        onStart != null ? () => onStart!(consultation) : null,
                  ),
                ),
              )
              .toList(),
    );
  }
}
