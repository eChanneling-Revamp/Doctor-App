import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/patient_history_entry.dart';

class HistoryCard extends StatelessWidget {
  final PatientHistoryEntry entry;

  const HistoryCard({super.key, required this.entry});

  static const _typeConfig = {
    HistoryType.prescription: (
      icon: Icons.receipt_long_rounded,
      color: Color(0xFF4A3FFF),
      bg: Color(0xFFEEF2FF),
    ),
    HistoryType.labResult: (
      icon: Icons.biotech_rounded,
      color: Color(0xFF0EA5E9),
      bg: Color(0xFFE0F2FE),
    ),
    HistoryType.visit: (
      icon: Icons.local_hospital_rounded,
      color: Color(0xFF10B981),
      bg: Color(0xFFE6F7EB),
    ),
    HistoryType.procedure: (
      icon: Icons.medical_services_rounded,
      color: Color(0xFFF59E0B),
      bg: Color(0xFFFEF3C7),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final cfg = _typeConfig[entry.type]!;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon badge
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: cfg.bg,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(cfg.icon, color: cfg.color, size: 20.r),
            ),
            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        entry.date,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    entry.subtitle,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                  ),
                  if (entry.note != null) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.notes_rounded,
                            size: 13.r,
                            color: Colors.black38,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              entry.note!,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black54,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
