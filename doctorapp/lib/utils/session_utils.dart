import 'package:flutter/material.dart';

/// Utility helpers for session-related formatting and presentation logic.
class SessionUtils {
  const SessionUtils._();

  /// Formats a DateTime into `Mon dd, yyyy` (e.g., `Nov 5, 2025`).
  static String formatDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final mm = months[d.month - 1];
    return '$mm ${d.day}, ${d.year}';
  }

  /// Formats a DateTime into `dd/MM/yyyy` with leading zeros.
  static String formatDMY(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  /// Parses a date string in `dd/MM/yyyy` format into a DateTime.
  /// Returns null if the input is null, empty, or invalid.
  static DateTime? parseDate(String? ddMMyyyy) {
    if (ddMMyyyy == null || ddMMyyyy.isEmpty) return null;
    final parts = ddMMyyyy.split('/');
    if (parts.length != 3) return null;
    final d = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final y = int.tryParse(parts[2]);
    if (d == null || m == null || y == null) return null;
    return DateTime(y, m, d);
  }

  /// Returns a color for the session type.
  static Color colorForType(String type) =>
      type == 'Hospital' ? const Color(0xFF10B981) : const Color(0xFF6D28D9);

  /// Updates the max patients text keeping the current prefix.
  ///
  /// Example: `10/20 Patients` with `newMax=30` => `10/30 Patients`.
  static String updateMaxPatientsText(String current, int newMax) {
    return current.replaceFirst(RegExp(r"/(\d+)"), '/$newMax');
  }
}
