
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class EventController {
  Future<List<Map<String, dynamic>>> fetchData(DateTime date) async {
    final url = Uri.parse("https://history.muffinlabs.com/date/${date.month}/${date.day}");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load events');
    }

    final jsonData = jsonDecode(response.body);
    final List events = jsonData['data']['Events'];

    final random = Random();
    final chosen = <Map<String, dynamic>>[];


    while (chosen.length < 5 && chosen.length < events.length) {
  final e = Map<String, dynamic>.from(events[random.nextInt(events.length)]);
  if (!chosen.any((event) => event["year"] == e["year"] && event["text"] == e["text"])) {
    chosen.add(e);
  }
  }

    while (chosen.length < 5) {
    chosen.add({
    "year": "-",
    "text": "Kein weiteres Ereignis"
    });
    }

    chosen.sort((a, b) {
      if (a["year"] == "-" || b["year"] == "-") return 1;
      return int.parse(b["year"]).compareTo(int.parse(a["year"]));
      });
  
  return chosen;
  }

}