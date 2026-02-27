import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/share_widgets/inputs.dart';
import '../../widgets/prescription_widgets.dart/favorite_medicine_list.dart';
import '../../widgets/prescription_widgets.dart/prescription_entry_card.dart';
import '../../widgets/prescription_widgets.dart/prescription_header_and_actions.dart';
import '../../models/prescription_entry.dart';
import '../../utils/snackbar_utils.dart';
import '../../services/drug_api.dart';
import '../../services/prescription_pdf_service.dart';

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
  final TextEditingController specialNoteController = TextEditingController();

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
    specialNoteController.dispose();
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
        final toRemove = entries
            .where((e) => e.medicineName == medicine)
            .toList();
        for (final r in toRemove) {
          r.dispose();
          entries.remove(r);
        }
        return;
      }

      // Check if medicine already exists in entries
      if (entries.any((e) => e.medicineName == medicine)) {
        // Medicine already in prescription, just mark it as selected
        selectedFavoriteIndices.add(index);
        SnackbarUtils.info(context, 'Medicine already added');
        return;
      }

      // select
      selectedFavoriteIndices.add(index);

      // add entry
      final newEntry = PrescriptionEntry(medicineName: medicine);
      newEntry.isFavorite =
          true; // Mark as favorite since it's from favorites list
      entries.add(newEntry);
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

  // ─── PDF Share ────────────────────────────────────────────────────────────

  void _showShareOptions() {
    final hasContent =
        entries.isNotEmpty || specialNoteController.text.trim().isNotEmpty;
    if (!hasContent) {
      SnackbarUtils.info(
        context,
        'Please add a medicine or a special note before sharing.',
      );
      return;
    }
    _generateAndShare();
  }

  /// Generates the PDF then shows system share sheet.
  Future<void> _generateAndShare() async {
    if (!mounted) return;
    final nav = Navigator.of(context);
    _showLoadingDialog('Generating PDF…');
    try {
      final file = await PrescriptionPdfService.generate(
        patientName: 'Mary De Silva',
        patientAge: '28',
        patientId: 'E00210',
        refNumber: 'App-2025002',
        status: 'Active',
        entries: entries,
        specialNote: specialNoteController.text,
        signatureBytes: _signatureBytes,
      );
      if (!mounted) return;
      nav.pop(); // close loading
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'application/pdf')],
          subject: 'ePrescription – Mary De Silva',
        ),
      );
    } catch (e) {
      if (!mounted) return;
      nav.pop();
      SnackbarUtils.error(context, 'Failed to generate PDF. Please try again.');
    }
  }

  void _showLoadingDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                const CircularProgressIndicator(),
                SizedBox(width: 20.w),
                Text(message, style: TextStyle(fontSize: 14.sp)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────

  void _onToggleFavorite(int index, String medicineName, bool isFavorite) {
    setState(() {
      if (isFavorite) {
        // Add to favorites list if not already there
        if (!favoriteMedicines.contains(medicineName)) {
          favoriteMedicines.add(medicineName);
          // Mark the tick for the newly added favorite
          selectedFavoriteIndices.add(favoriteMedicines.length - 1);
        } else {
          // Already in favorites, just mark the tick
          final favIndex = favoriteMedicines.indexOf(medicineName);
          if (favIndex >= 0) {
            selectedFavoriteIndices.add(favIndex);
          }
        }
      } else {
        // Get index before removing
        final favIndex = favoriteMedicines.indexOf(medicineName);
        // Remove from favorites list
        if (favIndex >= 0) {
          favoriteMedicines.removeAt(favIndex);
          // Clear selection for this index
          selectedFavoriteIndices.remove(favIndex);
          // Update all indices greater than removed index
          final updatedIndices = <int>{};
          for (final idx in selectedFavoriteIndices) {
            if (idx > favIndex) {
              updatedIndices.add(idx - 1);
            } else {
              updatedIndices.add(idx);
            }
          }
          selectedFavoriteIndices.clear();
          selectedFavoriteIndices.addAll(updatedIndices);
        }
      }
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
        title: Text(
          'ePrescription',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  hintText: 'Search Active Appointment',
                  controller: appointmentSearchController,
                  suffixIcon: const Icon(Icons.search),
                ),
                const PrescriptionHeader(),
                SizedBox(height: 14.h),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Medicine',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
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
                        SizedBox(height: 8.h),
                        if (isSearching)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Center(
                              child: SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                        if (!isSearching && searchResults.isNotEmpty)
                          Container(
                            constraints: BoxConstraints(maxHeight: 200.h),
                            child: Card(
                              margin: EdgeInsets.only(top: 6.r),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: searchResults.length,
                                separatorBuilder: (_, __) =>
                                    Divider(height: 1.h),
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
                                        setState(() {
                                          searchResults = [];
                                          medicineSearchController.clear();
                                        });
                                        return;
                                      }
                                      setState(() {
                                        final newEntry = PrescriptionEntry(
                                          medicineName: name,
                                        );
                                        // Check if this medicine is already in favorites
                                        if (favoriteMedicines.contains(name)) {
                                          newEntry.isFavorite = true;
                                        }
                                        entries.add(newEntry);
                                        searchResults = [];
                                        medicineSearchController.clear();
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFF59E0B)),
                            SizedBox(width: 8.w),
                            Text(
                              'Favorite Medicine',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        FavoriteMedicineList(
                          favorites: favoriteMedicines,
                          selectedIndices: selectedFavoriteIndices,
                          onTap: _onFavoriteTap,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 14.h),
                Text(
                  'Prescription Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 8.h),

                // Show medicine entries when medicines are added
                if (entries.isNotEmpty)
                  Column(
                    children: List.generate(
                      entries.length,
                      (i) => PrescriptionEntryCard(
                        entry: entries[i],
                        index: i,
                        onRemove: _removeEntry,
                        onToggleFavorite: _onToggleFavorite,
                      ),
                    ),
                  ),

                // Always show special note card
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.note_add,
                              color: const Color(0xFF3B82F6),
                              size: 24.r,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Special Note',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: const Color(0xFFF59E0B),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: const Color(0xFFD97706),
                                size: 20.r,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  'Use this note for special instructions.',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xFF78350F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Note for Patient',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: specialNoteController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                'Enter special instructions or notes for the patient...',
                            hintStyle: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey.shade400,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                color: Color(0xFF3B82F6),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 18.h),
                PrescriptionBottomActions(
                  onShare: _showShareOptions,
                  onSend: () => SnackbarUtils.info(context, 'Sent to patient'),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
