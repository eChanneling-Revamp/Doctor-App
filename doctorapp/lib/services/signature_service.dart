import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

/// Persists the doctor's drawn signature as a PNG file in the app
/// documents directory so it survives app restarts.
class SignatureService {
  static const _fileName = 'doctor_signature.png';

  /// Returns the path to the signature file.
  static Future<String> _signaturePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_fileName';
  }

  /// Saves [bytes] (PNG) to disk. Overwrites any previous signature.
  static Future<void> save(Uint8List bytes) async {
    final file = File(await _signaturePath());
    await file.writeAsBytes(bytes, flush: true);
  }

  /// Loads and returns the saved signature bytes, or `null` if none saved yet.
  static Future<Uint8List?> load() async {
    final file = File(await _signaturePath());
    if (!await file.exists()) return null;
    return file.readAsBytes();
  }

  /// Deletes the saved signature.
  static Future<void> clear() async {
    final file = File(await _signaturePath());
    if (await file.exists()) await file.delete();
  }
}
