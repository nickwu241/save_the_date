import 'package:save_the_date/models.dart';

const _currentYear = 2020;
final _months = {
  'january': 1,
  'february': 2,
  'march': 3,
  'april': 4,
  'may': 5,
  'june': 6,
  'july': 7,
  'august': 8,
  'september': 9,
  'october': 10,
  'november': 11,
  'december': 12,
  'jan': 1,
  'feb': 2,
  'mar': 3,
  'apr': 4,
  'may': 5,
  'june': 6,
  'july': 7,
  'aug': 8,
  'sept': 9,
  'oct': 10,
  'nov': 11,
  'dec': 12,
};

CalendarEvent parseText({
  String title,
  String text,
  Duration defaultDuration = const Duration(hours: 1),
}) {
  final re = getDatetimeRegExp();
  final matches =
      re.allMatches(text).map((m) => getGroups(m).toList()).toList();

  if (matches.isEmpty) {
    print('[ERROR] parseText: failed to parse to CalendarEvent: text=' + text);
    return null;
  }

  print('[INFO] parseText: found start date');
  final start = getDatetimeFromMatch(matches[0]);

  // Get endDate if available
  var end = start.add(defaultDuration);
  if (matches.length > 1) {
    print('[INFO] parseText: found end date');
    end = getDatetimeFromMatch(matches[1]);
  } else {
    print(
        "[INFO] parseText: didn't find end date, using default duration=$defaultDuration");
  }

  if (matches.length > 2) {
    print('[WARN] parseText: got >= 3 datetimes: text=' + text);
  }

  print('[SUCCESS] parseText: returning CalendarEvent($title, $start, $end)');
  return CalendarEvent(title: title, startDate: start, endDate: end);
}

RegExp getDatetimeRegExp() {
  const month =
      r'(?<month>jan(?:uary)?|feb(?:ruary)?|mar(?:ch)?|apr(?:il)?|may|jun(?:e)?|jul(?:y)?|aug(?:ust)?|sep(?:tember)?|oct(?:ober)?|nov(?:ember)?|dec(?:ember)?)';
  const day = r'(?<day>\d{1,2})';
  const time = r'(?<hour>(\d{1,2})(:(?<minutes>\d{2}))?)';
  const ampm = r'(?<ampm>am|pm)?';
  return RegExp(
    month + r',?\s*' + day + r',?\s*' + time + r'\s*' + ampm,
    caseSensitive: false,
    multiLine: true,
  );
}

List<String> getGroups(RegExpMatch match) {
  final month = match.namedGroup('month');
  final day = match.namedGroup('day');
  final hour = match.namedGroup('hour');
  final minutes = match.namedGroup('minutes');
  final ampm = match.namedGroup('ampm');
  return [month, day, hour, minutes, ampm];
}

DateTime getDatetimeFromMatch(List<String> match, {int year = _currentYear}) {
  final month = _months[match[0].toLowerCase()];
  final day = int.parse(match[1]);
  var hour = 0;
  if (match[2] != null) {
    hour = int.parse(match[2]);
    final ampm = match[4];
    if (ampm != null && ampm.toLowerCase() == 'pm') {
      hour += 12;
    }
  }
  final minutes = match[3] != null ? match[3] : 0;
  return DateTime(year, month, day, hour, minutes);
}
