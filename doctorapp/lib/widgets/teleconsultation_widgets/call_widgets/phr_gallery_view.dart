import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/teleconsultation_service.dart';
import 'pdf_loader.dart';
import 'dots_indicator.dart';

class PhrGalleryView extends StatefulWidget {
  final List<PHRMedia> items;
  const PhrGalleryView({super.key, required this.items});

  @override
  State<PhrGalleryView> createState() => _PhrGalleryViewState();
}

class _PhrGalleryViewState extends State<PhrGalleryView> {
  late final PageController _page;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _page = PageController();
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 4.h),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).maybePop(),
                tooltip: 'Close',
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  _titleFor(items[_index]),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                tooltip: 'Previous document',
                onPressed: _index > 0
                    ? () => _page.previousPage(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeOut,
                      )
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next document',
                onPressed: _index < items.length - 1
                    ? () => _page.nextPage(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeOut,
                      )
                    : null,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: PageView.builder(
            controller: _page,
            onPageChanged: (i) => setState(() => _index = i),
            itemCount: items.length,
            itemBuilder: (context, i) {
              final m = items[i];
              switch (m.type) {
                case PHRMediaType.image:
                  return InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 5,
                    child: Center(
                      child: Image.network(m.url, fit: BoxFit.contain),
                    ),
                  );
                case PHRMediaType.pdf:
                  return PdfLoader(url: m.url);
              }
            },
          ),
        ),
        SizedBox(height: 8.h),
        DotsIndicator(count: items.length, index: _index),
        SizedBox(height: 8.h),
      ],
    );
  }

  String _titleFor(PHRMedia m) =>
      m.title ?? (m.type == PHRMediaType.pdf ? 'PDF document' : 'Image');
}
