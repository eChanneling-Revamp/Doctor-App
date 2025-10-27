import 'package:flutter/material.dart';

class SessionGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SessionGroup({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        if (children.isEmpty) const Text('No sessions for selected filter.'),
        ...children,
      ],
    );
  }
}
