import 'package:flutter/material.dart';

class ScheduleEditHeader extends StatelessWidget {
  final String title;

  const ScheduleEditHeader({super.key, this.title = 'Schedule Edit'});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Schedule Edit',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}
