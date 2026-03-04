import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../models/prescription_entry.dart';

/// Service to generate a professional ePrescription PDF.
class PrescriptionPdfService {
  // ─── Brand colours ────────────────────────────────────────────────────────
  static final _primary = PdfColor.fromHex('4A3FFF');
  static final _primaryLight = PdfColor.fromHex('EEF2FF');
  static final _border = PdfColor.fromHex('E5E7EB');
  static final _textGrey = PdfColor.fromHex('6B7280');
  static final _rowAlt = PdfColor.fromHex('F9FAFB');
  static final _yellowBg = PdfColor.fromHex('FFFBEB');
  static final _yellowBorder = PdfColor.fromHex('FCD34D');
  static final _green = PdfColor.fromHex('10B981');
  static final _greenBg = PdfColor.fromHex('ECFDF5');

  // ─── Public API ───────────────────────────────────────────────────────────

  /// Generates the PDF and returns the [File] in the system temp directory.
  ///
  /// Pass [signatureBytes] (PNG) to embed the doctor's drawn signature;
  /// omit it to leave a blank signature line.
  static Future<File> generate({
    // Patient
    required String patientName,
    required String patientAge,
    required String patientId,
    required String refNumber,
    required String status,
    // Prescription content
    required List<PrescriptionEntry> entries,
    required String specialNote,
    // Doctor
    String doctorName = 'Dr. [Doctor Name]',
    String licenseNo = 'MD-XXXXX',
    String clinicName = 'Doctor App Clinic',
    // Digital signature image (PNG bytes from draw-to-sign pad)
    Uint8List? signatureBytes,
  }) async {
    final pdf = pw.Document();

    final now = DateTime.now();
    final dateStr =
        '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}';
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 36, vertical: 32),
        header: (context) => _pageHeader(
          context,
          dateStr,
          timeStr,
          doctorName,
          licenseNo,
          clinicName,
        ),
        footer: (context) => _pageFooter(context),
        build: (context) => [
          pw.SizedBox(height: 12),
          _patientCard(patientName, patientAge, patientId, refNumber, status),
          pw.SizedBox(height: 18),
          if (entries.isNotEmpty) ...[
            _medicinesSection(entries),
            pw.SizedBox(height: 18),
          ] else
            _noMedicinesBox(),
          if (specialNote.trim().isNotEmpty) ...[
            pw.SizedBox(height: 4),
            _specialNoteSection(specialNote),
            pw.SizedBox(height: 18),
          ],
          _signatureSection(
            doctorName,
            licenseNo,
            dateStr,
            signatureBytes: signatureBytes,
          ),
        ],
      ),
    );

    final dir = await getTemporaryDirectory();
    final fileName =
        'ePrescription_${patientId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}'
        '_${now.millisecondsSinceEpoch}.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  // ─── Page Header ──────────────────────────────────────────────────────────

  static pw.Widget _pageHeader(
    pw.Context context,
    String date,
    String time,
    String doctorName,
    String licenseNo,
    String clinicName,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: pw.BoxDecoration(
        color: _primary,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Left – branding / doctor
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'ePrescription',
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                clinicName,
                style: pw.TextStyle(fontSize: 11, color: PdfColors.white),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                doctorName,
                style: pw.TextStyle(
                  fontSize: 13,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
              pw.Text(
                'License No: $licenseNo',
                style: pw.TextStyle(fontSize: 10, color: PdfColors.white),
              ),
            ],
          ),
          // Right – date/time
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(6),
                  ),
                ),
                child: pw.Text(
                  date,
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: _primary,
                  ),
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Time: $time',
                style: pw.TextStyle(fontSize: 10, color: PdfColors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Page Footer ──────────────────────────────────────────────────────────

  static pw.Widget _pageFooter(pw.Context context) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 8),
      child: pw.Column(
        children: [
          pw.Divider(color: _border),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Generated by Doctor App  •  Confidential Medical Record',
                style: pw.TextStyle(fontSize: 8, color: _textGrey),
              ),
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: pw.TextStyle(fontSize: 8, color: _textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Patient Info Card ────────────────────────────────────────────────────

  static pw.Widget _patientCard(
    String name,
    String age,
    String id,
    String ref,
    String status,
  ) {
    final isActive = status.toLowerCase() == 'active';
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: _primaryLight,
        border: pw.Border.all(color: _primary, width: 0.8),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Patient Information',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 13,
                  color: _primary,
                ),
              ),
              // Status badge
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: pw.BoxDecoration(
                  color: isActive ? _greenBg : PdfColors.grey200,
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(20),
                  ),
                ),
                child: pw.Text(
                  status,
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: isActive ? _green : _textGrey,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Divider(color: _border),
          pw.SizedBox(height: 8),
          pw.Row(
            children: [
              _infoField('Patient Name', name),
              pw.SizedBox(width: 16),
              _infoField('Age', '$age years'),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            children: [
              _infoField('Patient ID', id),
              pw.SizedBox(width: 16),
              _infoField('Reference No.', ref),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _infoField(String label, String value) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label, style: pw.TextStyle(fontSize: 9, color: _textGrey)),
          pw.SizedBox(height: 2),
          pw.Text(
            value,
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ─── Medicines Table ──────────────────────────────────────────────────────

  static pw.Widget _medicinesSection(List<PrescriptionEntry> entries) {
    const headerStyle = pw.TextStyle(fontSize: 10, color: PdfColors.white);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Section title
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: pw.BoxDecoration(
            color: _primary,
            borderRadius: pw.BorderRadius.only(
              topLeft: const pw.Radius.circular(8),
              topRight: const pw.Radius.circular(8),
            ),
          ),
          child: pw.Row(
            children: [
              pw.Text(
                'Prescribed Medicines',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 13,
                  color: PdfColors.white,
                ),
              ),
              pw.SizedBox(width: 8),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(12),
                  ),
                ),
                child: pw.Text(
                  '${entries.length} ${entries.length == 1 ? 'Medicine' : 'Medicines'}',
                  style: pw.TextStyle(
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                    color: _primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Table
        pw.Table(
          border: pw.TableBorder.all(color: _border, width: 0.5),
          columnWidths: const {
            0: pw.FixedColumnWidth(22),
            1: pw.FlexColumnWidth(2.0),
            2: pw.FlexColumnWidth(1.2),
            3: pw.FixedColumnWidth(46),
            4: pw.FlexColumnWidth(1.0),
            5: pw.FlexColumnWidth(2.0),
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColor.fromHex('6366F1')),
              children: [
                _th('#', headerStyle),
                _th('Medicine Name', headerStyle),
                _th('Dosage', headerStyle),
                _th('Freq/Day', headerStyle),
                _th('Duration', headerStyle),
                _th('Special Instructions', headerStyle),
              ],
            ),
            // Data rows
            for (int i = 0; i < entries.length; i++)
              pw.TableRow(
                decoration: pw.BoxDecoration(
                  color: i.isEven ? PdfColors.white : _rowAlt,
                ),
                children: [
                  _td('${i + 1}', center: true),
                  _td(entries[i].medicineName, bold: true),
                  _td(entries[i].dosageController.text),
                  _td('${entries[i].frequency}×', center: true),
                  _td(entries[i].period),
                  _td(
                    entries[i].instructionsController.text.trim().isEmpty
                        ? '—'
                        : entries[i].instructionsController.text.trim(),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _th(String text, pw.TextStyle style) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 7),
      child: pw.Text(
        text,
        style: style.copyWith(fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  static pw.Widget _td(String text, {bool bold = false, bool center = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: pw.Text(
        text,
        textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  // ─── No medicines placeholder ─────────────────────────────────────────────

  static pw.Widget _noMedicinesBox() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: _border),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Center(
        child: pw.Text(
          'No medicines prescribed',
          style: pw.TextStyle(color: _textGrey, fontSize: 12),
        ),
      ),
    );
  }

  // ─── Special Note ─────────────────────────────────────────────────────────

  static pw.Widget _specialNoteSection(String note) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: _yellowBg,
        border: pw.Border.all(color: _yellowBorder, width: 0.8),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '⚠  Special Note for Patient',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
              color: PdfColor.fromHex('92400E'),
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            note.trim(),
            style: pw.TextStyle(
              fontSize: 11,
              color: PdfColor.fromHex('78350F'),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Signature Section ────────────────────────────────────────────────────

  static pw.Widget _signatureSection(
    String doctorName,
    String licenseNo,
    String date, {
    Uint8List? signatureBytes,
  }) {
    // Build the signature visual: drawn image OR blank space
    final pw.Widget signatureVisual = signatureBytes != null
        ? pw.Container(
            width: 200,
            height: 70,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: _border, width: 0.5),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
            ),
            child: pw.Image(
              pw.MemoryImage(signatureBytes),
              fit: pw.BoxFit.contain,
            ),
          )
        : pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 50), // blank signing space
              pw.Container(width: 200, height: 0.8, color: PdfColors.black),
            ],
          );

    return pw.Column(
      children: [
        pw.Divider(color: _border),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Heading
                pw.Text(
                  'Authorised by',
                  style: pw.TextStyle(fontSize: 9, color: _textGrey),
                ),
                pw.SizedBox(height: 6),
                // Signature image or blank
                signatureVisual,
                pw.SizedBox(height: 6),
                pw.Text(
                  doctorName,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                pw.Text(
                  'License No: $licenseNo',
                  style: pw.TextStyle(fontSize: 9, color: _textGrey),
                ),
                pw.Text(
                  'Date: $date',
                  style: pw.TextStyle(fontSize: 9, color: _textGrey),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: _primaryLight,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
          ),
          child: pw.Text(
            'This prescription has been digitally generated via Doctor App and is valid only when '
            'accompanied by the treating physician\'s official stamp and signature.',
            style: pw.TextStyle(
              fontSize: 8,
              color: _primary,
              fontStyle: pw.FontStyle.italic,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ],
    );
  }
}
