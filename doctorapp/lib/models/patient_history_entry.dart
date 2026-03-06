enum HistoryType { prescription, labResult, visit, procedure }

class PatientHistoryEntry {
  final String title;
  final String subtitle;
  final String date;
  final HistoryType type;
  final String? note;

  const PatientHistoryEntry({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.type,
    this.note,
  });
}
