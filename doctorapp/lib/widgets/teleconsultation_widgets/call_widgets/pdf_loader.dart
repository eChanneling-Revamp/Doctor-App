import 'dart:typed_data';
import 'package:flutter/material.dart';
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
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError || snap.data == null) {
          return SimpleError(
            title: 'Failed to load PDF',
            message: snap.error?.toString() ?? 'Unknown error',
          );
        }
        return PdfViewWithController(bytes: snap.data!);
      },
    );
  }
}
