import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/teleconsultation_service.dart';
import 'phr_gallery_view.dart';
import 'simple_error.dart';

class PHRViewer extends StatelessWidget {
  final String appointmentId;
  const PHRViewer({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    final svc = TeleconsultationService.instance;
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.98,
      expand: false,
      builder: (_, controller) => FutureBuilder<List<PHRMedia>>(
        future: svc.getPhrMedia(appointmentId: appointmentId),
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
          if (snap.hasError || (snap.data?.isEmpty ?? true)) {
            return const SafeArea(
              child: SimpleError(
                title: 'PHR not available',
                message: 'No PHR documents/images for this appointment.',
              ),
            );
          }
          return SafeArea(child: PhrGalleryView(items: snap.data!));
        },
      ),
    );
  }
}
