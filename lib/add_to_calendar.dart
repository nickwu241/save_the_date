import 'package:add_2_calendar/add_2_calendar.dart';

Future<bool> addToCalendar(String title, DateTime startDate, DateTime endDate,
    {String description: '', String location: ''}) {
  final event = Event(
    title: title,
    description: description,
    location: location,
    startDate: startDate,
    endDate: endDate,
  );

  return Add2Calendar.addEvent2Cal(event);
}
