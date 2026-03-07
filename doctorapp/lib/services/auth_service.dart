import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // Get base URL from environment or use default
  static String get baseUrl => dotenv.env['API_URL'] ?? 'http://localhost:3000';

  static String get apiUrl => '$baseUrl/api/auth';

  // Store token after successful login
  static String? _authToken;

  static String? get authToken => _authToken;

  static void setAuthToken(String token) {
    _authToken = token;
  }

  static void clearAuthToken() {
    _authToken = null;
  }

  // Register new doctor account
  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String medicalSpec,
    required String hospital,
    required String slmcNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'password': password,
          'medicalSpec': medicalSpec,
          'hospital': hospital,
          'slmcNumber': slmcNumber,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        return {
          'success': true,
          'message': data['message'] ?? 'Registration successful',
          'data': data['data'],
        };
      } else {
        // Registration failed
        return {
          'success': false,
          'message': data['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Login with email and password
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Login successful - store token
        if (data['data'] != null && data['data']['token'] != null) {
          setAuthToken(data['data']['token']);
        }

        return {
          'success': true,
          'message': data['message'] ?? 'Login successful',
          'data': data['data'],
          'token': data['data']?['token'],
        };
      } else {
        // Login failed
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Request password reset OTP
  static Future<Map<String, dynamic>> forgotPassword({
    required String emailOrPhone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'emailOrPhone': emailOrPhone}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'OTP sent successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to send OTP',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Verify OTP code
  static Future<Map<String, dynamic>> verifyOtp({
    required String emailOrPhone,
    required String code,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'emailOrPhone': emailOrPhone, 'code': code}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'OTP verified successfully',
        };
      } else {
        return {'success': false, 'message': data['message'] ?? 'Invalid OTP'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Reset password
  static Future<Map<String, dynamic>> resetPassword({
    required String emailOrPhone,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'emailOrPhone': emailOrPhone,
          'newPassword': newPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Password reset successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to reset password',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Logout
  static Future<Map<String, dynamic>> logout() async {
    try {
      // If no token exists, just return success (already logged out)
      if (_authToken == null) {
        return {'success': true, 'message': 'Logged out successfully'};
      }

      // Try to notify backend about logout
      final response = await http.post(
        Uri.parse('$apiUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_authToken',
        },
      );

      clearAuthToken();

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Logged out successfully'};
      } else {
        return {
          'success': true, // Still clear local token even if server fails
          'message': 'Logged out successfully',
        };
      }
    } catch (e) {
      clearAuthToken(); // Clear token even on error
      return {'success': true, 'message': 'Logged out successfully'};
    }
  }
}
