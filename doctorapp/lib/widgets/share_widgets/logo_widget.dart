import 'package:flutter/material.dart';

// Logo Widget
class LogoWidget extends StatelessWidget {
  final double size;

  const LogoWidget({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        'assets/images/logo.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
