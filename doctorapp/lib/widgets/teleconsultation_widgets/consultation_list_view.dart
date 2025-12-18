import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: EdgeInsets.all(32.r),
          child: Text(
            emptyText,
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      children: consultations
          .map(
            (consultation) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: ConsultationCard(
                consultation: consultation,
                onStart: onStart != null ? () => onStart!(consultation) : null,
              ),
            ),
          )
          .toList(),
    );
  }
}
