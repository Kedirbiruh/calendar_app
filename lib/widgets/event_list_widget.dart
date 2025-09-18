import 'package:flutter/material.dart';
import 'package:kalender_app/controllers/event_controller.dart';

class EventListWidget extends StatefulWidget {
  final DateTime date;

  const EventListWidget({super.key, required this.date});

  @override
  State<EventListWidget> createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget> {
  late Future<List<Map<String, dynamic>>> futureEvents;
  final EventController eventController = EventController();

  @override
  void initState() {
    super.initState();
    futureEvents = eventController.fetchData(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: futureEvents,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Fehler beim Laden der Events'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final events = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return ListTile(title: Text('${event["year"]}: ${event["text"]}', 
            style: const TextStyle(fontSize: 12),));
            
          },
        );
      },
    );
  }
}
