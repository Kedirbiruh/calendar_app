import 'package:flutter/material.dart';
import 'calendar_screen.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      debugShowCheckedModeBanner: false,
      title: 'Mein Kalender',
      home: CalendarScreen(title: 'My Calendar'),
    );
  }
}
