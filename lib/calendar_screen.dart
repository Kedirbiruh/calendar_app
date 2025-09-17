import 'package:flutter/material.dart';
import 'package:kalender_app/controllers/holiday_controller.dart';
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
  DateTime selectedDate = DateTime.now();
  HolidayController holidayController = HolidayController();

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }

  // Info_Box Variablen
  String weekdayName = "";
  String nthWeekday = "";
  String holidayName = "";
  String monthName = "";
  int daysInMonth = 0;

  @override
  void initState() {
    super.initState();
    _updateInfoBox(selectedDate);
  }

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

  void _updateInfoBox(DateTime date) {
    final holiday = holidayController.getHolidayForDate(date);
    setState(() {
      selectedDate = date;
      weekdayName = _getWeekdayGerman(date.weekday);
      nthWeekday = getNthWeekdayInMonth(date);
      holidayName = holiday?.name ?? 'kein Feiertag';
      daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    });
  }

  String _getWeekdayGerman(int weekday) {
    const weekdayNames = [
      "Montag",
      "Dienstag",
      "Mittwoch",
      "Donnerstag",
      "Freitag",
      "Samstag",
      "Sonntag",
    ];
    return weekdayNames[weekday - 1];
  }

  String getNthWeekdayInMonth(DateTime date) {
    int count = 0;
    for (int day = 1; day <= date.day; day++) {
      if (DateTime(date.year, date.month, day).weekday == date.weekday) {
        count++;
      }
    }

    switch (count) {
      case 1:
        return "erste";
      case 2:
        return "zweite";
      case 3:
        return "dritte";
      case 4:
        return "vierte";
      case 5:
        return "fünfte";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final weeks = DateFunctions.buildMonth(currentDate.year, currentDate.month);

    List<Widget> dayWidgets = [];
    for (var week in weeks) {
      for (var day in week) {
        bool isCurrentMonth = day.month == currentDate.month;
        dayWidgets.add(
          DaySelectable(
            date: day,
            isCurrentMonth: isCurrentMonth,
            onDateSelected: (selectedDay) {
              _updateInfoBox(selectedDay);
            },
          ),
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

          // Info-Box
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Der ${formatDate(selectedDate)} " 
                  "ist ein $weekdayName und zwar der $nthWeekday $weekdayName im Monat ${DateFunctions.onlyMonthName(selectedDate)} "
                  "des Jahres ${DateFunctions.onlyYear(selectedDate)}."
                  "Dieser ${DateFunctions.onlyMonthName(selectedDate)} hat $daysInMonth Tage." "Heute ist $holidayName",
                  style: const TextStyle(fontSize: 14),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
