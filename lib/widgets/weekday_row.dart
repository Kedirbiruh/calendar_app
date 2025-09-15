import 'package:flutter/material.dart';

class WeekdayRow extends StatelessWidget {
  const WeekdayRow({super.key});

  @override
  Widget build(BuildContext context) {
    final weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
    List<Widget> weekdayWidgets = [];

    for (var day in weekdays) {
      weekdayWidgets.add(
        Expanded(
          child: Center(
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
    return Row(children: weekdayWidgets);
  }
}
