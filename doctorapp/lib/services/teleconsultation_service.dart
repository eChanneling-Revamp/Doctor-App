import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Media types supported in PHR viewer
enum PHRMediaType { pdf, image }

/// A single PHR media item (PDF or Image)
class PHRMedia {
  final String url;
  final PHRMediaType type;
  final String? title;
  const PHRMedia({required this.url, required this.type, this.title});
}

/// Service utilities for teleconsultation flows.
///
/// Reads all configuration from .env via flutter_dotenv. No zego_config.dart.
class TeleconsultationService {
  TeleconsultationService._();
  static final TeleconsultationService instance = TeleconsultationService._();


  String currentDoctorUserId() {
    // TODO: get doctor id from auth service
    return buildUserId(role: 'doctor', id: 'demo_doctor');
  }

  /// Build a standardized userID for ZEGOCLOUD from app role + internal id.
  /// Examples: doctor_123, patient_456
  String buildUserId({required String role, required String id}) {
    final r = role.toLowerCase();
    if (r != 'doctor' && r != 'patient') {
      throw ArgumentError('role must be "doctor" or "patient"');
    }
    return '${r}_$id';
  }

  /// Quick client-side check to avoid accidental third joins.
  /// Server-side token gating is still required for security.
  bool isUserAllowedForAppointment({
    required String role,
    required String userId,
    String? doctorId,
    String? patientId,
  }) {
    final expectedDoctor =
        doctorId == null ? null : buildUserId(role: 'doctor', id: doctorId);
    final expectedPatient =
        patientId == null ? null : buildUserId(role: 'patient', id: patientId);

    if (role == 'doctor') {
      if (expectedDoctor != null) return userId == expectedDoctor;
      return userId.startsWith('doctor_');
    } else if (role == 'patient') {
      if (expectedPatient != null) return userId == expectedPatient;
      return userId.startsWith('patient_');
    }
    return false;
  }

  /// Fetch ZEGOCLOUD token from your backend if configured.
  ///
  /// Returns token string on success; null if token mode is disabled or
  /// not properly configured. Never throws for configuration issues.
  Future<String?> getZegoToken({
    required String userId,
    required String appointmentId,
    required String role,
  }) async {
    // Check if token-based auth is enabled
    final useTokenRaw = dotenv.env['ZEGO_USE_TOKEN'] ?? 'false';
    final useToken = useTokenRaw.toLowerCase() == 'true';
    if (!useToken) return null;

    // Validate token server URL
    final tokenServer = (dotenv.env['ZEGO_TOKEN_SERVER'] ?? '').trim();
    if (tokenServer.isEmpty ||
        !(tokenServer.startsWith('http://') ||
            tokenServer.startsWith('https://'))) {
      // Misconfigured for now; fall back to appSign mode
      return null;
    }

    // AppID is required by most sample token servers
    final appIdStr = dotenv.env['ZEGO_APP_ID'] ?? '';
    final appId = int.tryParse(appIdStr);

    try {
      final uri = Uri.parse(tokenServer).replace(
        queryParameters: {
          if (appId != null) 'app_id': appId.toString(),
          // Some servers expect these keys; harmless if ignored
          'room_id': appointmentId,
          'user_id': userId,
          'role': role,
        },
      );

      final resp = await http.get(uri).timeout(const Duration(seconds: 10));
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        return null;
      }

      final data = json.decode(resp.body);
      if (data is Map) {
        // Accept { token: '...' } or { data: { token: '...' } }
        final direct = data['token'];
        if (direct is String && direct.isNotEmpty) return direct;
        final nested = (data['data'] is Map) ? data['data']['token'] : null;
        if (nested is String && nested.isNotEmpty) return nested;
      }
    } catch (_) {
      // Network/parse errors: silently fall back to appSign mode
      return null;
    }

    return null;
  }

  /// Fetch PHR data for the given appointment.
  ///
  /// NOTE: This is a placeholder implementation for UI wiring. Replace with
  /// a real API call that returns the patient's health record associated with
  /// the appointment/patient.
  
  
  // Future<Map<String, dynamic>> getPHR({required String appointmentId}) async {
  //   await Future.delayed(const Duration(milliseconds: 350));
  //   return {
  //     'patient': {
  //       'name': 'Mary De Silva',
  //       'dob': '1985-03-12',
  //       'sex': 'F',
  //       'bloodGroup': 'O+',
  //       'appointmentId': appointmentId,
  //     },
  //     'allergies': ['Penicillin', 'Peanuts'],
  //     'medications': [
  //       {'name': 'Metformin', 'dose': '500 mg', 'schedule': 'BID'},
  //       {'name': 'Atorvastatin', 'dose': '20 mg', 'schedule': 'OD at night'},
  //     ],
  //     'diagnoses': ['Type 2 Diabetes Mellitus', 'Hypercholesterolemia'],
  //     'labs': [
  //       {'test': 'HbA1c', 'value': '7.4%', 'date': '2025-05-01'},
  //       {'test': 'LDL-C', 'value': '130 mg/dL', 'date': '2025-04-15'},
  //     ],
  //   };
  // }

  /// In production, your backend should return a signed/authorized URL to the
  /// PHR documents for this appointment/patient. For now, we allow multiple
  /// PDFs and images via .env:
  /// - PHR_PDF_URLS: comma-separated list of PDF URLs
  /// - PHR_IMAGE_URLS: comma-separated list of image URLs (png/jpg)
  /// If none provided, falls back to a demo PDF and a stock image.
  Future<List<PHRMedia>> getPhrMedia({required String appointmentId}) async {
    List<PHRMedia> items = [];

    String env(String k) => (dotenv.env[k] ?? '').trim();
    final pdfs =
        env(
          'PHR_PDF_URLS',
        ).split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    final images =
        env(
          'PHR_IMAGE_URLS',
        ).split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

    items.addAll(pdfs.map((u) => PHRMedia(url: u, type: PHRMediaType.pdf)));
    items.addAll(images.map((u) => PHRMedia(url: u, type: PHRMediaType.image)));

    if (items.isEmpty) {
      // Defaults for demo/testing
      items = [
        const PHRMedia(
          url:
              'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
          type: PHRMediaType.pdf,
          title: 'PHR Summary',
        ),
        const PHRMedia(
          url: 'https://picsum.photos/1000/1400',
          type: PHRMediaType.image,
          title: 'Scan Image',
        ),
      ];
    }

    return items;
  }

  /// Backward-compat: single PDF URL if needed.
  Future<String?> getPhrPdfUrl({required String appointmentId}) async {
    // Optional: read a demo URL from .env
    final demo = (dotenv.env['PHR_DEMO_URL'] ?? '').trim();
    if (demo.isNotEmpty) return demo;
    // TODO: Replace with real API endpoint using [appointmentId]
    return 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
  }

  /// Download PDF bytes from a URL. Handles basic network errors by throwing.
  Future<Uint8List> downloadPdf(String url) async {
    final resp = await http
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 20));
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return resp.bodyBytes;
    }
    throw Exception('Failed to download PDF (${resp.statusCode})');
  }

  /// General helper to download any bytes (image/pdf). Alias to downloadPdf.
  Future<Uint8List> downloadBytes(String url) => downloadPdf(url);
}
