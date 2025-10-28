import 'package:flutter/material.dart';

// Fingerprint Button
class FingerprintButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FingerprintButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.fingerprint,
              size: 30,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Use Fingerprint',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// Password Strength Indicator
class PasswordStrengthIndicator extends StatelessWidget {
  final String label;
  final bool isValid;

  const PasswordStrengthIndicator({
    super.key,
    required this.label,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          size: 16,
          color: isValid ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isValid ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}
