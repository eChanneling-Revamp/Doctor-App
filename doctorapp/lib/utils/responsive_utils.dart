import 'package:flutter_screenutil/flutter_screenutil.dart';
class ResponsiveUtils {
  // Screen width percentage
  static double screenWidth(double percent) => percent.sw;

  // Screen height percentage
  static double screenHeight(double percent) => percent.sh;

  // Responsive width
  static double width(double value) => value.w;

  // Responsive height
  static double height(double value) => value.h;

  // Responsive font size
  static double fontSize(double value) => value.sp;

  // Responsive radius
  static double radius(double value) => value.r;

  // Common spacing values (use .r for padding/margins per guidelines)
  static double get spacing4 => 4.r;
  static double get spacing8 => 8.r;
  static double get spacing12 => 12.r;
  static double get spacing16 => 16.r;
  static double get spacing20 => 20.r;
  static double get spacing24 => 24.r;
  static double get spacing32 => 32.r;
  static double get spacing40 => 40.r;
  static double get spacing48 => 48.r;

  // Common font sizes
  static double get fontSizeSmall => 12.sp;
  static double get fontSizeMedium => 14.sp;
  static double get fontSizeRegular => 16.sp;
  static double get fontSizeLarge => 18.sp;
  static double get fontSizeXLarge => 20.sp;
  static double get fontSizeTitle => 24.sp;
  static double get fontSizeHeading => 28.sp;
}
