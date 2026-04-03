class Session {
  final String id;
  final String doctorId;
  final String nurseId;
  final String hospitalId;
  final String hospitalName;
  final String sessionType; // 'Teleconsultation' or 'Hospital'
  final int patientCapacity;
  final int capacity;
  final String location;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime scheduledAt;
  final String status; // 'SCHEDULED', 'ONGOING', 'COMPLETED', 'CANCELLED'
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<dynamic> appointments;

  Session({
    required this.id,
    required this.doctorId,
    required this.nurseId,
    required this.hospitalId,
    required this.hospitalName,
    required this.sessionType,
    required this.patientCapacity,
    required this.capacity,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.scheduledAt,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.appointments = const [],
  });

  /// Convert from JSON
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      nurseId: json['nurseId'] ?? '',
      hospitalId: json['hospitalId'] ?? '',
      hospitalName: json['hospitalName'] ?? '',
      sessionType: json['sessionType'] ?? '',
      patientCapacity: json['patientCapacity'] ?? 0,
      capacity: json['capacity'] ?? json['patientCapacity'] ?? 0,
      location: json['location'] ?? '',
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'].toString())
          : DateTime.now(),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'].toString())
          : DateTime.now(),
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.parse(json['scheduledAt'].toString())
          : DateTime.now(),
      status: json['status'] ?? 'SCHEDULED',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : null,
      appointments: json['appointments'] ?? [],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'nurseId': nurseId,
      'hospitalId': hospitalId,
      'hospitalName': hospitalName,
      'sessionType': sessionType,
      'patientCapacity': patientCapacity,
      'capacity': capacity,
      'location': location,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'scheduledAt': scheduledAt.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'appointments': appointments,
    };
  }

  /// Create a copy with modifications
  Session copyWith({
    String? id,
    String? doctorId,
    String? nurseId,
    String? hospitalId,
    String? hospitalName,
    String? sessionType,
    int? patientCapacity,
    int? capacity,
    String? location,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? scheduledAt,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? appointments,
  }) {
    return Session(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      nurseId: nurseId ?? this.nurseId,
      hospitalId: hospitalId ?? this.hospitalId,
      hospitalName: hospitalName ?? this.hospitalName,
      sessionType: sessionType ?? this.sessionType,
      patientCapacity: patientCapacity ?? this.patientCapacity,
      capacity: capacity ?? this.capacity,
      location: location ?? this.location,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      appointments: appointments ?? this.appointments,
    );
  }

  /// Get available slots
  int get availableSlots {
    return capacity - appointments.length;
  }

  /// Check if session has available slots
  bool get hasAvailableSlots {
    return availableSlots > 0;
  }

  /// Check if session is in the past
  bool get isCompleted {
    return DateTime.now().isAfter(endTime);
  }

  /// Check if session is currently ongoing
  bool get isOngoing {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  /// Check if session is upcoming
  bool get isUpcoming {
    return DateTime.now().isBefore(startTime);
  }

  /// Get duration in minutes
  int get durationInMinutes {
    return endTime.difference(startTime).inMinutes;
  }

  /// Format start time as HH:MM
  String get formattedStartTime {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  }

  /// Format end time as HH:MM
  String get formattedEndTime {
    return '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }

  /// Format date as DD/MM/YYYY
  String get formattedDate {
    return '${startTime.day.toString().padLeft(2, '0')}/${startTime.month.toString().padLeft(2, '0')}/${startTime.year}';
  }

  @override
  String toString() {
    return 'Session(id: $id, hospitalName: $hospitalName, sessionType: $sessionType, startTime: $startTime, endTime: $endTime)';
  }
}
