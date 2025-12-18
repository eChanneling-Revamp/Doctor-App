import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Logo Widget
class LogoWidget extends StatelessWidget {
  final double size;

  const LogoWidget({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.r,
      height: size.r,
      child: Image.asset(
        'assets/images/logo.png',
        width: size.r,
        height: size.r,
        fit: BoxFit.contain,
      ),
    );
  }
}
