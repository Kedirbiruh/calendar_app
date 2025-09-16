import 'package:flutter/material.dart';
import 'package:kalender_app/date_functions.dart';
import 'package:kalender_app/widgets/calendar_header.dart';
import 'package:kalender_app/widgets/day_selectable.dart';
import 'package:kalender_app/widgets/weekday_row.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key, required this.title});

  final String title;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime currentDate = DateTime.now();

  void previousMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
    });
  }

  void nextMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Matrix von Wochen mit Tagen
    final weeks = DateFunctions.buildMonth(currentDate.year, currentDate.month);

    // Liste von DaySelectable-Widgets
    List<Widget> dayWidgets = [];
    for (var week in weeks) {
      for (var day in week) {
        bool isCurrentMonth = day.month == currentDate.month;
        dayWidgets.add(
          DaySelectable(date: day, isCurrentMonth: isCurrentMonth),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 171, 197, 194),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Header mit Monatsname und Navigation
          CalendarHeader(
            currentDate: currentDate,
            onPreviousMonth: previousMonth,
            onNextMonth: nextMonth,
          ),

          // Wochentagsreihe
          const WeekdayRow(),

          // Grid für die Tage
          Expanded(
            child: GridView.count(crossAxisCount: 7, children: dayWidgets),
          ),
        ],
      ),
    );
  }
}
