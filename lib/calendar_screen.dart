import 'package:flutter/material.dart';
import 'package:kalender_app/controllers/holiday_controller.dart';
import 'package:kalender_app/date_functions.dart';
import 'package:kalender_app/widgets/weekday_row.dart';
import 'package:kalender_app/widgets/calendar_header.dart';
import 'package:kalender_app/widgets/day_selectable.dart';
import 'package:kalender_app/widgets/event_list_widget.dart';

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

  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Info_Box Variablen
  String weekdayName = "";
  String nthWeekday = "";
  String holidayName = "";
  String monthName = "";
  int daysInMonth = 0;

  void previousMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
      _updateInfoBox(DateTime(currentDate.year, currentDate.month, 1));
    });
  }

  void nextMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
      _updateInfoBox(DateTime(currentDate.year, currentDate.month, 1));
    });
  }

  @override
  void initState() {
    super.initState();
    _updateInfoBox(selectedDate);
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
    final dayOfMonth = date.day;

    if (dayOfMonth < 8) return "erste";
    if (dayOfMonth < 15) return "zweite";
    if (dayOfMonth < 22) return "dritte";
    if (dayOfMonth < 29) return "vierte";
    return "fünfte";
  }

  @override
  Widget build(BuildContext context) {
    final weeks = DateFunctions.buildMonth(currentDate.year, currentDate.month);
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight * 0.4;
    final gridHeight = availableHeight;
    final rowHeight = gridHeight / 6;

    List<Widget> dayWidgets = [];
    for (var week in weeks) {
      for (var day in week) {
        bool isCurrentMonth = day.month == currentDate.month;
        dayWidgets.add(
          DaySelectable(
            date: normalizeDate(day),
            isCurrentMonth: isCurrentMonth,
            holidayController: holidayController,
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
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 198, 235, 200),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              //constrainedBox oder eigene widget.....
              CalendarHeader(
                currentDate: currentDate,
                onPreviousMonth: previousMonth,
                onNextMonth: nextMonth,
              ),
              const WeekdayRow(),
              SizedBox(
                height: gridHeight,
                child: GridView.count(
                  crossAxisCount: 7,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio:
                      (MediaQuery.of(context).size.width / 7) / rowHeight,
                  padding: EdgeInsets.zero,
                  children: dayWidgets,
                ),
              ),
              // InfoBox
              Container(
                width: 500,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      "Info",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Der ${formatDate(selectedDate)} "
                      "ist ein $weekdayName und zwar der $nthWeekday $weekdayName im Monat ${DateFunctions.onlyMonthName(selectedDate)} "
                      "des Jahres ${DateFunctions.onlyYear(selectedDate)}. "
                      "Dieser ${DateFunctions.onlyMonthName(selectedDate)} hat $daysInMonth Tage. "
                      "Heute ist $holidayName.",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "History on ${formatDate(selectedDate)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(child: EventListWidget(date: selectedDate)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
