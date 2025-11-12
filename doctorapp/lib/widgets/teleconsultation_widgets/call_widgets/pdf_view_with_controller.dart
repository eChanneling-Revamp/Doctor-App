import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewWithController extends StatefulWidget {
  final Uint8List bytes;
  const PdfViewWithController({super.key, required this.bytes});

  @override
  State<PdfViewWithController> createState() => _PdfViewWithControllerState();
}

class _PdfViewWithControllerState extends State<PdfViewWithController> {
  late final PdfControllerPinch _controller;
  bool _docReady = false;

  @override
  void initState() {
    super.initState();
    _controller = PdfControllerPinch(
      document: PdfDocument.openData(widget.bytes),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).maybePop(),
                tooltip: 'Close',
              ),
              const SizedBox(width: 8),
              const Text(
                'Patient Health Record (PDF)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                tooltip: 'Previous page',
                onPressed: _docReady
                    ? () => _controller.previousPage(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeOut,
                      )
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next page',
                onPressed: _docReady
                    ? () => _controller.nextPage(
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
          child: PdfViewPinch(
            controller: _controller,
            onDocumentLoaded: (_) {
              if (mounted) setState(() => _docReady = true);
            },
            onDocumentError: (error) {
              if (mounted) setState(() => _docReady = false);
            },
          ),
        ),
      ],
    );
  }
}
