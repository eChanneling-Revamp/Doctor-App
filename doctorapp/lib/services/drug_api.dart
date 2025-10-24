import 'dart:convert';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

/// Simple drug search using RxNav (NLM) APIs.
/// Returns a list of matching medication names (strings).
class DrugApi {
  /// Searches RxNorm suggested RxTerms for the given query.
  /// Uses the RxNav "approximateTerm" endpoint which returns candidate RxCUI(s),
  /// then fetches names. This is a lightweight approach and avoids API keys.
  static Future<List<String>> searchMedicines(String query) async {
    if (query.trim().isEmpty) return [];
    final encoded = Uri.encodeQueryComponent(query);

    // Use RxNav approximateTerm to get candidates
    final approxUrl = Uri.parse(
      'https://rxnav.nlm.nih.gov/REST/approximateTerm.json?term=$encoded&maxEntries=20',
    );
    // Perform HTTP request with timeout and robust error handling.
    try {
      final approxRes = await http
          .get(approxUrl)
          .timeout(const Duration(seconds: 8));

      if (approxRes.statusCode != 200) {
        developer.log(
          'RxNav approximateTerm returned non-200 status',
          name: 'DrugApi',
          error: 'status=${approxRes.statusCode}',
          // include body to help debugging (may be large)
          stackTrace: StackTrace.fromString(approxRes.body),
        );
        return [];
      }

      final approxJson = jsonDecode(approxRes.body) as Map<String, dynamic>;
      final candidates = <String>[];

      try {
        final candidateList =
            ((approxJson['approximateGroup'] ?? {})['candidate'] ?? []) as List;
        for (final c in candidateList) {
          final name = (c['rxcuiName'] ?? c['name']) as String?;
          if (name != null && name.isNotEmpty) candidates.add(name);
        }
      } catch (e, st) {
        // Log parse errors so we can diagnose unexpected response shapes
        developer.log(
          'Failed to parse RxNav candidate list',
          name: 'DrugApi',
          error: e,
          stackTrace: st,
        );
      }

      // Remove duplicates and return
      final unique = candidates.toSet().toList();
      return unique;
    } on TimeoutException catch (e, st) {
      developer.log(
        'Timeout calling RxNav approximateTerm',
        name: 'DrugApi',
        error: e,
        stackTrace: st,
      );
      return [];
    } catch (e, st) {
      // Catch any other network / decode / unexpected errors and log them
      developer.log(
        'Unexpected error in DrugApi.searchMedicines',
        name: 'DrugApi',
        error: e,
        stackTrace: st,
      );
      return [];
    }
  }
}
