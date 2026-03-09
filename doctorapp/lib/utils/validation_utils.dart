class ValidationUtils {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Phone number validation (Sri Lankan format)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact number is required';
    }

    // Remove spaces and special characters
    final cleanedPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check for Sri Lankan mobile format
    // Accepts: 0771234567, +94771234567, 94771234567
    final phoneRegex = RegExp(r'^(?:\+?94|0)?[1-9]\d{8}$');

    if (!phoneRegex.hasMatch(cleanedPhone)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Full name validation
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }

    if (value.trim().length < 2) {
      return 'Full name must be at least 2 characters long';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Full name can only contain letters and spaces';
    }

    return null;
  }

  // SLMC number validation
  static String? validateSLMCNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'SLMC number is required';
    }

    // Remove spaces and special characters
    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');

    // SLMC numbers are typically 5-6 digits
    final slmcRegex = RegExp(r'^\d{5,6}$');

    if (!slmcRegex.hasMatch(cleaned)) {
      return 'Please enter a valid SLMC number (5-6 digits)';
    }

    return null;
  }

  // Hospital name validation
  static String? validateHospital(String? value) {
    if (value == null || value.isEmpty) {
      return 'Hospital name is required';
    }

    if (value.trim().length < 3) {
      return 'Hospital name must be at least 3 characters long';
    }

    return null;
  }

  // Specialty validation
  static String? validateSpecialty(String? value) {
    if (value == null || value.isEmpty || value == 'Select your specialty') {
      return 'Please select your medical specialty';
    }

    return null;
  }

  // Generic required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}
