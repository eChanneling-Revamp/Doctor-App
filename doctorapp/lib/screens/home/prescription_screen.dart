import 'package:flutter/material.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/share_widgets/inputs.dart';
import '../../widgets/prescription_widgets.dart/favorite_medicine_list.dart';
import '../../widgets/prescription_widgets.dart/prescription_entry_card.dart';
import '../../widgets/prescription_widgets.dart/prescription_header_and_actions.dart';
import '../../models/prescription_entry.dart';
import '../../utils/snackbar_utils.dart';
import '../../services/drug_api.dart';
import 'dart:async';

class CreatePrescriptionScreen extends StatefulWidget {
  const CreatePrescriptionScreen({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (_) => const CreatePrescriptionScreen());

  @override
  State<CreatePrescriptionScreen> createState() =>
      _CreatePrescriptionScreenState();
}

class _CreatePrescriptionScreenState extends State<CreatePrescriptionScreen> {
  final TextEditingController appointmentSearchController =
      TextEditingController();
  final TextEditingController medicineSearchController =
      TextEditingController();

  // search state
  List<String> searchResults = [];
  bool isSearching = false;
  Timer? _debounce;

  // Sample favorite medicines
  final List<String> favoriteMedicines = [
    'Paracetamol 500mg',
    'Omeprazole 20mg',
    'Amoxicillin 500mg',
  ];

  // multi-selected favorites by index
  final Set<int> selectedFavoriteIndices = <int>{};

  // entries
  final List<PrescriptionEntry> entries = [];

  @override
  void dispose() {
    appointmentSearchController.dispose();
    medicineSearchController.dispose();
    _debounce?.cancel();
    for (final e in entries) {
      e.dispose();
    }
    super.dispose();
  }

  void _onFavoriteTap(String medicine, int index, bool currentlySelected) {
    setState(() {
      if (currentlySelected) {
        // deselect and remove any entries with that medicine
        selectedFavoriteIndices.remove(index);
        final toRemove =
            entries.where((e) => e.medicineName == medicine).toList();
        for (final r in toRemove) {
          r.dispose();
          entries.remove(r);
        }
        return;
      }

      // select
      selectedFavoriteIndices.add(index);

      // add entry if not exists
      if (!entries.any((e) => e.medicineName == medicine)) {
        entries.add(PrescriptionEntry(medicineName: medicine));
      } else {
        SnackbarUtils.info(context, 'Medicine already added');
      }
    });
  }

  void _removeEntry(int index) {
    setState(() {
      final removed = entries.removeAt(index);
      // dispose controllers
      removed.dispose();
      // if it was a favorite, clear its tick
      final favIndex = favoriteMedicines.indexOf(removed.medicineName);
      if (favIndex >= 0) selectedFavoriteIndices.remove(favIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const CustomBackButton(),
        centerTitle: true,
        title: const Text(
          'ePrescription',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                hintText: 'Search Active Appointment',
                controller: appointmentSearchController,
                suffixIcon: const Icon(Icons.search),
              ),
              const PrescriptionHeader(),
              const SizedBox(height: 14),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add Medicine',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: 'Search Medicine Name',
                        controller: medicineSearchController,
                        suffixIcon: const Icon(Icons.search),
                        onChanged: (v) async {
                          // debounce
                          _debounce?.cancel();
                          _debounce = Timer(
                            const Duration(milliseconds: 400),
                            () async {
                              if (v.trim().isEmpty) {
                                setState(() {
                                  searchResults = [];
                                  isSearching = false;
                                });
                                return;
                              }

                              setState(() {
                                isSearching = true;
                              });

                              try {
                                final results = await DrugApi.searchMedicines(
                                  v,
                                );
                                if (!mounted) return;
                                setState(() {
                                  searchResults = results;
                                  isSearching = false;
                                });
                              } catch (e) {
                                if (!mounted) return;
                                setState(() {
                                  isSearching = false;
                                });
                                SnackbarUtils.error(
                                  context,
                                  'Failed to search medicines. Please try again.',
                                );
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      if (isSearching)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                      if (!isSearching && searchResults.isNotEmpty)
                        Container(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: Card(
                            margin: const EdgeInsets.only(top: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: searchResults.length,
                              separatorBuilder:
                                  (_, __) => const Divider(height: 1),
                              itemBuilder: (context, idx) {
                                final name = searchResults[idx];
                                return ListTile(
                                  title: Text(name),
                                  onTap: () {
                                    // add to entries if not exists
                                    if (entries.any(
                                      (e) => e.medicineName == name,
                                    )) {
                                      SnackbarUtils.info(
                                        context,
                                        'Medicine already added',
                                      );
                                      return;
                                    }
                                    setState(() {
                                      entries.add(
                                        PrescriptionEntry(medicineName: name),
                                      );
                                      searchResults = [];
                                      medicineSearchController.clear();
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Color(0xFFF59E0B)),
                          SizedBox(width: 8),
                          Text(
                            'Favorite Medicine',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      FavoriteMedicineList(
                        favorites: favoriteMedicines,
                        selectedIndices: selectedFavoriteIndices,
                        onTap: _onFavoriteTap,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),
              const Text(
                'Prescription Details',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),

              Column(
                children: List.generate(
                  entries.length,
                  (i) => PrescriptionEntryCard(
                    entry: entries[i],
                    index: i,
                    onRemove: _removeEntry,
                  ),
                ),
              ),

              const SizedBox(height: 18),
              PrescriptionBottomActions(
                onShare: () => SnackbarUtils.info(context, 'Shared'),
                onSend: () => SnackbarUtils.info(context, 'Sent to patient'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
