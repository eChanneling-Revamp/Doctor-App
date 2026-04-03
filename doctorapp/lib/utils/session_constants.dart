/// Configuration constants for hospitals and nurses
/// This can be made dynamic by fetching from backend API

// Hospital configurations
const Map<String, Map<String, String>> HOSPITALS = {
  'Hemas Hospital': {
    'id': 'hospital_001',
    'name': 'Hemas Hospital',
    'location': 'Colombo',
  },
  'City Clinic': {
    'id': 'hospital_002',
    'name': 'City Clinic',
    'location': 'Colombo',
  },
  'Ninewells Hospital': {
    'id': 'hospital_003',
    'name': 'Ninewells Hospital',
    'location': 'Kandy',
  },
  'Online Consultation': {
    'id': 'online_001',
    'name': 'Online Consultation',
    'location': 'Online',
  },
};

// Nurse configurations
const Map<String, Map<String, String>> NURSES = {
  'Default Nurse': {'id': 'nurse_001', 'name': 'Default Nurse'},
  'Nurse 1': {'id': 'nurse_001', 'name': 'Nurse 1'},
  'Nurse 2': {'id': 'nurse_002', 'name': 'Nurse 2'},
};

// Session types
const List<String> SESSION_TYPES = ['Teleconsultation', 'Hospital'];

// Session status
enum SessionStatus { SCHEDULED, ONGOING, COMPLETED, CANCELLED }

extension SessionStatusExt on SessionStatus {
  String get displayName {
    switch (this) {
      case SessionStatus.SCHEDULED:
        return 'Scheduled';
      case SessionStatus.ONGOING:
        return 'Ongoing';
      case SessionStatus.COMPLETED:
        return 'Completed';
      case SessionStatus.CANCELLED:
        return 'Cancelled';
    }
  }

  String get value {
    return toString().split('.').last;
  }
}

/// Helper function to get hospital ID by name
String getHospitalId(String hospitalName) {
  return HOSPITALS[hospitalName]?['id'] ?? 'hospital_001';
}

/// Helper function to get hospital name by ID
String? getHospitalNameById(String hospitalId) {
  for (var hospital in HOSPITALS.values) {
    if (hospital['id'] == hospitalId) {
      return hospital['name'];
    }
  }
  return null;
}

/// Helper function to get nurse ID by name
String getNurseId(String nurseName) {
  return NURSES[nurseName]?['id'] ?? 'nurse_001';
}

/// Helper function to get list of hospitals
List<String> getHospitalNames() {
  return HOSPITALS.keys.toList();
}

/// Helper function to get list of nurses
List<String> getNurseNames() {
  return NURSES.keys.toList();
}
