class DateFunctions {
  static const List<String> monthNames = [
    "Januar",
    "Februar",
    "März",
    "April",
    "Mai",
    "Juni",
    "Juli",
    "August",
    "September",
    "Oktober",
    "November",
    "Dezember",
  ];

  static String monthName(DateTime date) {
    return "${monthNames[date.month - 1]} ${date.year}";
  }

  static List<List<DateTime>> buildMonth(int year, int month) {
    final firstDay = DateTime(year, month, 1);
    final daysOfLastMonth = (firstDay.weekday + 6) % 7;
    final startDay = firstDay.subtract(Duration(days: daysOfLastMonth));
    final lastDay = DateTime(year, month + 1, 0);
    final daysInNextMonth = (7 - lastDay.weekday) % 7;
    final endDay = lastDay.add(Duration(days: daysInNextMonth));

    final weeks = <List<DateTime>>[];
    var currentWeek = <DateTime>[];
    for (
      var day = startDay;
      !day.isAfter(endDay);
      day = day.add(const Duration(days: 1))
    ) {
      currentWeek.add(day);

      if (day.weekday == DateTime.sunday) {
        weeks.add(currentWeek);
        currentWeek = [];
      }
    }
    if (currentWeek.isNotEmpty) {
      weeks.add(currentWeek);
    }
    return weeks;
  }
}
