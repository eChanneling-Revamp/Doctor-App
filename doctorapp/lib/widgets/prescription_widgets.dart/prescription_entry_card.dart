import 'package:flutter/material.dart';
import '../../utils/snackbar_utils.dart';
import '../share_widgets/inputs.dart';
import '../../models/prescription_entry.dart';

typedef OnRemoveEntry = void Function(int index);
typedef OnToggleFavorite =
    void Function(int index, String medicineName, bool isFavorite);

class PrescriptionEntryCard extends StatefulWidget {
  final PrescriptionEntry entry;
  final int index;
  final OnRemoveEntry onRemove;
  final OnToggleFavorite? onToggleFavorite;

  const PrescriptionEntryCard({
    super.key,
    required this.entry,
    required this.index,
    required this.onRemove,
    this.onToggleFavorite,
  });

  @override
  State<PrescriptionEntryCard> createState() => _PrescriptionEntryCardState();
}

class _PrescriptionEntryCardState extends State<PrescriptionEntryCard> {
  bool _editing = false;

  void _toggleEditSave() {
    if (_editing) {
      // Save: model already updated via controllers and dropdowns
      SnackbarUtils.success(context, 'Saved');
    }
    setState(() => _editing = !_editing);
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${widget.index + 1}. ${entry.medicineName}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton(
                  onPressed: _toggleEditSave,
                  icon: Icon(
                    _editing ? Icons.save : Icons.edit,
                    size: 20,
                    color: _editing ? Colors.green : Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () => widget.onRemove(widget.index),
                  icon: const Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dosage',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      CustomTextField(
                        hintText: '',
                        controller: entry.dosageController,
                        readOnly: !_editing,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Frequency',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<int>(
                        value: entry.frequency,
                        items: const [
                          DropdownMenuItem(value: 1, child: Text('1')),
                          DropdownMenuItem(value: 2, child: Text('2')),
                          DropdownMenuItem(value: 3, child: Text('3')),
                          DropdownMenuItem(value: 4, child: Text('4')),
                          DropdownMenuItem(value: 6, child: Text('6')),
                        ],
                        onChanged: _editing
                            ? (v) => setState(
                                () => entry.frequency = v ?? entry.frequency,
                              )
                            : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Duration',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: entry.period,
                        items: const [
                          DropdownMenuItem(
                            value: '1 Day',
                            child: Text('1 Day'),
                          ),
                          DropdownMenuItem(
                            value: '1 Week',
                            child: Text('1 Week'),
                          ),
                          DropdownMenuItem(
                            value: '2 Week',
                            child: Text('2 Week'),
                          ),
                          DropdownMenuItem(
                            value: '1 Month',
                            child: Text('1 Month'),
                          ),
                        ],
                        onChanged: _editing
                            ? (v) => setState(
                                () => entry.period = v ?? entry.period,
                              )
                            : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        entry.isFavorite = !entry.isFavorite;
                      });
                      widget.onToggleFavorite?.call(
                        widget.index,
                        entry.medicineName,
                        entry.isFavorite,
                      );
                      SnackbarUtils.success(
                        context,
                        entry.isFavorite
                            ? 'Added to favorites'
                            : 'Removed from favorites',
                      );
                    },
                    icon: Icon(
                      entry.isFavorite ? Icons.star : Icons.star_border,
                      color: entry.isFavorite
                          ? const Color(0xFFF59E0B)
                          : Colors.grey.shade600,
                    ),
                    label: Text(
                      entry.isFavorite ? 'Remove favorite' : 'Add to favorite',
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Text(
              'Special Instructions',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            CustomTextField(
              hintText: '',
              controller: entry.instructionsController,
              readOnly: !_editing,
            ),
          ],
        ),
      ),
    );
  }
}
