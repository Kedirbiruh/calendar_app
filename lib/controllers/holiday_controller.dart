class Holiday {
  final DateTime date;
  final String name;
  Holiday({required this.date, required this.name});
}

class HolidayController {
  Holiday? getHolidayForDate(DateTime date) {
    final feste = {
      DateTime(date.year, 1, 1): "Neujahr",
      DateTime(date.year, 5, 1): "Tag der Arbeit",
      DateTime(date.year, 10, 3): "Tag der Deutschen Einheit",
      DateTime(date.year, 12, 25): "1. Weihnachtstag",
      DateTime(date.year, 12, 26): "2. Weihnachtstag",
    };

    for (var entry in feste.entries) {
      if (_isSameDay(entry.key, date)) {
        return Holiday(date: entry.key, name: entry.value);
      }
    }

    final bewegliche = {
      getGoodFriday(date.year): "Karfreitag",
      getEasterSunday(date.year): "Ostersonntag",
      getEasterMonday(date.year): "Ostermontag",
      getAscensionDay(date.year): "Himmelfahrt",
      getPentecost(date.year): "Pfingsten",
      getCorpusChristi(date.year): "Fronleichnam",
    };
    for (var entry in bewegliche.entries) {
      if (_isSameDay(entry.key, date)) {
        return Holiday(date: entry.key, name: entry.value);
      }
    }
    return null;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Ostersonntag berechnen
  DateTime getEasterSunday(int year) {
    int a = year % 19;
    int b = year ~/ 100;
    int c = year % 100;
    int d = b ~/ 4;
    int e = b % 4;
    int f = (b + 8) ~/ 25;
    int g = (b - f + 1) ~/ 3;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c ~/ 4;
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 11 * h + 22 * l) ~/ 451;
    int month = ((h + l - 7 * m + 114) ~/ 31);
    int day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  DateTime getGoodFriday(int year) =>
      getEasterSunday(year).subtract(const Duration(days: 2));
  DateTime getEasterMonday(int year) =>
      getEasterSunday(year).add(const Duration(days: 1));
  DateTime getAscensionDay(int year) =>
      getEasterSunday(year).add(const Duration(days: 39));
  DateTime getPentecost(int year) =>
      getEasterSunday(year).add(const Duration(days: 49));
  DateTime getCorpusChristi(int year) =>
      getEasterSunday(year).add(const Duration(days: 60));
}
