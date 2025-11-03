import 'package:flutter/material.dart';
import 'consultation_card.dart';

class ConsultationListView extends StatelessWidget {
  final List<Map<String, dynamic>> consultations;
  final Function(Map<String, dynamic>)? onEdit;
  final Function(Map<String, dynamic>)? onDelete;

  const ConsultationListView({
    super.key,
    required this.consultations,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (consultations.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No upcoming teleconsultations',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
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
                    onEdit: onEdit != null ? () => onEdit!(consultation) : null,
                    onDelete:
                        onDelete != null ? () => onDelete!(consultation) : null,
                  ),
                ),
              )
              .toList(),
    );
  }
}
