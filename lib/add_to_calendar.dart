import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:save_the_date/models.dart';

Future<bool> addToCalendar(CalendarEvent calendarEvent) {
  final event = Event(
    title: calendarEvent.title,
    startDate: calendarEvent.startDate,
    endDate: calendarEvent.endDate,
    timeZone: 'GMT-7',
  );

  return Add2Calendar.addEvent2Cal(event);
}
