import 'dart:convert';
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

    final approxRes = await http
        .get(approxUrl)
        .timeout(const Duration(seconds: 8));
    if (approxRes.statusCode != 200) return [];

    final approxJson = jsonDecode(approxRes.body) as Map<String, dynamic>;
    final candidates = <String>[];

    try {
      final candidateList =
          ((approxJson['approximateGroup'] ?? {})['candidate'] ?? []) as List;
      for (final c in candidateList) {
        final name = (c['rxcuiName'] ?? c['name']) as String?;
        if (name != null && name.isNotEmpty) candidates.add(name);
      }
    } catch (_) {
      // ignore parse errors
    }

    // Remove duplicates and limit
    final unique = candidates.toSet().toList();
    return unique;
  }
}
