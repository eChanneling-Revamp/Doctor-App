import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';
import '../../services/signature_service.dart';
import '../../utils/snackbar_utils.dart';

/// Full-screen pad where the doctor draws their signature.
/// Returns `true` via [Navigator.pop] if a signature was saved.
class SignaturePadScreen extends StatefulWidget {
  /// Pre-existing signature bytes to pre-populate the pad (optional).
  final Uint8List? existingBytes;

  const SignaturePadScreen({super.key, this.existingBytes});

  /// Push route; awaited result is `true` when signature was saved.
  static Future<bool?> push(BuildContext context, {Uint8List? existingBytes}) {
    return Navigator.of(context).push<bool>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => SignaturePadScreen(existingBytes: existingBytes),
      ),
    );
  }

  @override
  State<SignaturePadScreen> createState() => _SignaturePadScreenState();
}

class _SignaturePadScreenState extends State<SignaturePadScreen> {
  late final SignatureController _ctrl;
  bool _isSaving = false;
  bool _hasStrokes = false;

  @override
  void initState() {
    super.initState();
    _ctrl = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      onDrawStart: () => setState(() => _hasStrokes = true),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_ctrl.isEmpty) {
      SnackbarUtils.info(context, 'Please draw your signature first.');
      return;
    }
    setState(() => _isSaving = true);
    try {
      final Uint8List? bytes = await _ctrl.toPngBytes(height: 300, width: 900);
      if (bytes == null) throw Exception('Export failed');
      await SignatureService.save(bytes);
      if (!mounted) return;
      SnackbarUtils.success(context, 'Signature saved successfully.');
      // Short delay so the snackbar is seen, then pop with true
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      SnackbarUtils.error(context, 'Failed to save signature. Please retry.');
    }
  }

  void _clear() {
    _ctrl.clear();
    setState(() => _hasStrokes = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        centerTitle: true,
        title: Text(
          'Draw Your Signature',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _hasStrokes ? _clear : null,
            child: Text(
              'Clear',
              style: TextStyle(
                color: _hasStrokes ? Colors.redAccent : Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Info banner ───────────────────────────────────────────────
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: const Color(0xFF4A3FFF),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: const Color(0xFF4A3FFF),
                      size: 18.r,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Sign inside the box below using your finger or stylus. '
                        'This signature will be embedded in every prescription PDF.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF3730A3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // ── Signature canvas ──────────────────────────────────────────
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFF4A3FFF),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      // Drawing area
                      Signature(
                        controller: _ctrl,
                        backgroundColor: Colors.white,
                      ),
                      // Placeholder text when empty
                      if (!_hasStrokes)
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.draw_outlined,
                                size: 48.r,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'Sign here',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              // Baseline hint
              Center(
                child: Container(
                  width: 200.w,
                  height: 1,
                  color: Colors.grey.shade300,
                  margin: EdgeInsets.only(bottom: 4.h),
                ),
              ),
              Center(
                child: Text(
                  'Signature baseline',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // ── Save button ───────────────────────────────────────────────
              SizedBox(
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A3FFF),
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 0,
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          'Save Signature',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              SizedBox(height: 12.h),

              // Cancel
              SizedBox(
                height: 48.h,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
