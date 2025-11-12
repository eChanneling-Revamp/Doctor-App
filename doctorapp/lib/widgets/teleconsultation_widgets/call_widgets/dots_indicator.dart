import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int count;
  final int index;
  const DotsIndicator({super.key, required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == index ? Colors.blueAccent : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
