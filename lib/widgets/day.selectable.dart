import 'package:flutter/material.dart';

class DaySelectable extends StatelessWidget {
  final int dayNumber;
  final bool isCurrentMonth;

  const DaySelectable({
    super.key,
    required this.dayNumber,
    required this.isCurrentMonth, // ← hier wird der Parameter akzeptiert
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Tag $dayNumber geklickt");
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade200,
        ),
        child: Center(
          child: Text("$dayNumber", style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
