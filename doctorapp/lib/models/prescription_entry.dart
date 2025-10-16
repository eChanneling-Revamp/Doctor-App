import 'package:flutter/widgets.dart';

class PrescriptionEntry {
  final String medicineName;
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  int frequency = 1;
  String period = '1 Week';
  bool isFavorite = false;

  PrescriptionEntry({required this.medicineName}) {
    dosageController.text = '1 tablet';
    instructionsController.text = '';
  }

  void dispose() {
    dosageController.dispose();
    instructionsController.dispose();
  }
}
