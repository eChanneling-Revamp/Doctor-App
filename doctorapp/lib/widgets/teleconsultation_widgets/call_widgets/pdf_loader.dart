import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/teleconsultation_service.dart';
import 'pdf_view_with_controller.dart';
import 'simple_error.dart';

class PdfLoader extends StatelessWidget {
  final String url;
  const PdfLoader({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final svc = TeleconsultationService.instance;
    return FutureBuilder<Uint8List>(
      future: svc.downloadBytes(url),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              height: 40.r,
              width: 40.r,
              child: CircularProgressIndicator(strokeWidth: 3.r),
            ),
          );
        }
        if (snap.hasError || snap.data == null) {
          return SafeArea(
            child: SimpleError(
              title: 'Failed to load PDF',
              message: snap.error?.toString() ?? 'Unknown error',
            ),
          );
        }
        return SafeArea(child: PdfViewWithController(bytes: snap.data!));
      },
    );
  }
}
