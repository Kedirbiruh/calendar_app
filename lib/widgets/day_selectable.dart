import 'package:flutter/material.dart';
import 'package:kalender_app/controllers/holiday_controller.dart';

class DaySelectable extends StatelessWidget {
  final DateTime date;
  final bool isCurrentMonth;
  final DateTime? birthday;
  final today = DateTime.now();
  final HolidayController holidayController;
  final Function(DateTime)? onDateSelected;


  DaySelectable({
    super.key,
    required this.date,
    required this.isCurrentMonth,
    required this.holidayController,
    this.birthday,
    this.onDateSelected,
  });

  bool isToday() {
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  bool isSaturday() {
    return date.weekday == DateTime.saturday;
  }

  bool isSunday() {
    return date.weekday == DateTime.sunday;
  }

  bool isAndreBirthday(month, day) {
    return month == 8 && day == 6;
  }

  @override
  Widget build(BuildContext context) {
    Color background = const Color.fromARGB(255, 238, 236, 236);
    Color textColor = Colors.black;
    final holiday = holidayController.getHolidayForDate(date);

    if (isToday()) {
      background = const Color.fromARGB(255, 160, 228, 233);
    } else if (isAndreBirthday(date.month, date.day)) {
      background = const Color.fromARGB(230, 193, 223, 197);
    } else if (!isCurrentMonth) {
      background = const Color.fromARGB(0, 228, 225, 225);
      textColor = const Color.fromARGB(255, 175, 175, 175);
    } else if (isSaturday()) {
      background = const Color.fromARGB(255, 198, 197, 226);
    } else if (isSunday()) {
      background = const Color.fromARGB(255, 221, 178, 178);
    }
    if (holiday != null && isCurrentMonth) {
      background = const Color.fromARGB(255, 156, 235, 10);
      // textColor = Colors.black;
    }

    return InkWell(
      onTap: () {
        if (onDateSelected != null ) onDateSelected!(date);
        print("Tag ${date.day} geklickt");
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: background,
        ),
        child: Center(
          child: Text(
            "${date.day}",
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        ),
      ),
    );
  }
}
