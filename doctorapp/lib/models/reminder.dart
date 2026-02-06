import 'package:flutter/material.dart';

class Reminder {
  Reminder({
    required this.title,
    required this.time,
    required this.repeat,
    this.description,
    this.category = 'Medicine Reminder',
    this.enabled = true,
  });

  final String title;
  final TimeOfDay time;
  final String repeat;
  final String? description;
  final String category;
  bool enabled;
}
