import 'package:flutter/material.dart';

class DaySelectable extends StatelessWidget {
  final DateTime date;
  final bool isCurrentMonth;
  final DateTime? birthday;
  final now = DateTime.now();
  
  

  DaySelectable({
    super.key,
    required this.date,
    required this.isCurrentMonth,
    this.birthday,
  });

  bool isToday() {
    return date.year == now.year &&
      date.month == now.month &&
        date.day == now.day;
      
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

    if (isToday()) {
    background = const Color.fromARGB(255, 160, 228, 233);
    } else if (isAndreBirthday(date.month, date.day)) {
    background = const Color.fromARGB(230, 193, 223, 197);
    } else if (!isCurrentMonth) {
    background = const Color.fromARGB(0, 228, 225, 225);
    textColor = const Color.fromARGB(255, 175, 175, 175);
    } else if (isSaturday()) {
    background = const Color.fromARGB(255, 198, 197, 226);
    }else if (isSunday()) {
    background = const Color.fromARGB(255, 221, 178, 178);
    }

    return InkWell(
      onTap: () {
        print("Tag ${date.day} geklickt");
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: background,
        ),
        child: Center(
          child: Text("${date.day}", style: TextStyle(fontSize: 16, color: textColor)),
        ),
      ),
    );
  }
}



 