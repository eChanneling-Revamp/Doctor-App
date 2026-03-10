import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'auth_service.dart';

class ProfileService {
  static String get baseUrl => dotenv.env['API_URL'] ?? 'http://localhost:3000';
  static String get apiUrl => '$baseUrl/api/profile';

  // Get user profile
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      // Load persisted token if not already in memory
      if (AuthService.authToken == null) {
        await AuthService.initializeToken();
      }
      final token = AuthService.authToken;
      if (token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch profile',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Update user profile
  static Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    required String email,
    required String phone,
    required String medicalSpec,
    required String hospital,
    required String slmcNumber,
    String? profileImage,
  }) async {
    try {
      if (AuthService.authToken == null) await AuthService.initializeToken();
      final token = AuthService.authToken;
      if (token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'medicalSpec': medicalSpec,
          'hospital': hospital,
          'slmcNumber': slmcNumber,
          if (profileImage != null) 'profileImage': profileImage,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Profile updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to update profile',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Change password
  static Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      if (AuthService.authToken == null) await AuthService.initializeToken();
      final token = AuthService.authToken;
      if (token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.put(
        Uri.parse('$apiUrl/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Password changed successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to change password',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Toggle biometric login
  static Future<Map<String, dynamic>> toggleBiometric({
    required bool enabled,
  }) async {
    try {
      if (AuthService.authToken == null) await AuthService.initializeToken();
      final token = AuthService.authToken;
      if (token == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      final response = await http.put(
        Uri.parse('$apiUrl/biometric'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'enabled': enabled}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Biometric setting updated',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to update biometric setting',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }
}
