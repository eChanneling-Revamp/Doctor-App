import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/session_model.dart';
import 'auth_service.dart';

class SessionService {
  static String get baseUrl => dotenv.env['API_URL'] ?? 'http://localhost:3000';

  static String get apiUrl => '$baseUrl/api/sessions';

  /// Create a new session
  static Future<Session> createSession({
    required String doctorId,
    required String hospitalId,
    required String nurseId,
    required String hospitalName,
    required int patientCapacity,
    required DateTime startTime,
    required DateTime endTime,
    required String sessionType,
    required String location,
    String? notes,
  }) async {
    try {
      final token = AuthService.authToken;

      if (token == null) {
        throw Exception('Authentication required. Please login first.');
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'doctorId': doctorId,
          'hospitalId': hospitalId,
          'nurseId': nurseId,
          'hospitalName': hospitalName,
          'patientCapacity': patientCapacity,
          'startTime': startTime.toIso8601String(),
          'endTime': endTime.toIso8601String(),
          'sessionType': sessionType,
          'location': location,
          'notes': notes ?? '',
          'scheduledAt': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          return Session.fromJson(jsonResponse['data']);
        }
        throw Exception('Invalid response format');
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        throw Exception(jsonResponse['error'] ?? 'Failed to create session');
      } else {
        throw Exception('Failed to create session: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating session: $e');
    }
  }

  /// Get all sessions for a doctor
  static Future<List<Session>> getSessionsByDoctor(
    String doctorId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final token = AuthService.authToken;

      if (token == null) {
        throw Exception('Authentication required. Please login first.');
      }

      final queryParams = {
        'doctorId': doctorId,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };

      final uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final List<dynamic> sessionsJson = jsonResponse['data'];
          return sessionsJson.map((json) => Session.fromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('Failed to fetch sessions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching sessions: $e');
    }
  }

  /// Get a single session by ID
  static Future<Session> getSessionById(String sessionId) async {
    try {
      final token = AuthService.authToken;

      if (token == null) {
        throw Exception('Authentication required. Please login first.');
      }

      final response = await http.get(
        Uri.parse('$apiUrl/$sessionId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          return Session.fromJson(jsonResponse['data']);
        }
        throw Exception('Invalid response format');
      } else if (response.statusCode == 404) {
        throw Exception('Session not found');
      } else {
        throw Exception('Failed to fetch session: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching session: $e');
    }
  }

  /// Update a session
  static Future<Session> updateSession(
    String sessionId, {
    String? hospitalName,
    int? patientCapacity,
    DateTime? startTime,
    DateTime? endTime,
    String? sessionType,
    String? location,
    String? notes,
  }) async {
    try {
      final token = AuthService.authToken;

      if (token == null) {
        throw Exception('Authentication required. Please login first.');
      }

      final body = <String, dynamic>{};
      if (hospitalName != null) body['hospitalName'] = hospitalName;
      if (patientCapacity != null) body['patientCapacity'] = patientCapacity;
      if (startTime != null) body['startTime'] = startTime.toIso8601String();
      if (endTime != null) body['endTime'] = endTime.toIso8601String();
      if (sessionType != null) body['sessionType'] = sessionType;
      if (location != null) body['location'] = location;
      if (notes != null) body['notes'] = notes;

      final response = await http.put(
        Uri.parse('$apiUrl/$sessionId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          return Session.fromJson(jsonResponse['data']);
        }
        throw Exception('Invalid response format');
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        throw Exception(jsonResponse['error'] ?? 'Failed to update session');
      } else {
        throw Exception('Failed to update session: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating session: $e');
    }
  }

  /// Delete a session
  static Future<bool> deleteSession(String sessionId) async {
    try {
      final token = AuthService.authToken;

      if (token == null) {
        throw Exception('Authentication required. Please login first.');
      }

      final response = await http.delete(
        Uri.parse('$apiUrl/$sessionId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['success'] == true;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        final jsonResponse = jsonDecode(response.body);
        throw Exception(jsonResponse['error'] ?? 'Failed to delete session');
      } else {
        throw Exception('Failed to delete session: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting session: $e');
    }
  }

  /// Get patient count for a session
  static Future<Map<String, dynamic>> getSessionPatientCount(
    String sessionId,
  ) async {
    try {
      final token = AuthService.authToken;

      if (token == null) {
        throw Exception('Authentication required. Please login first.');
      }

      final response = await http.get(
        Uri.parse('$apiUrl/$sessionId/patient-count'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          return jsonResponse['data'];
        }
        throw Exception('Invalid response format');
      } else {
        throw Exception(
          'Failed to fetch patient count: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching patient count: $e');
    }
  }
}
