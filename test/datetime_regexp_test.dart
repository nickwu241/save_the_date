import 'package:flutter_test/flutter_test.dart';
import 'package:save_the_date/parse_text.dart';

void main() {
  group('getDatetimeRegExp', () {
    final re = getDatetimeRegExp();
    print(re.toString());

    test('should match "oct 1 7 pm"', () {
      final input = 'oct 1 7 pm';
      expect(re.hasMatch(input), true);
      expect(re.allMatches(input).length, 1);

      final match = re.firstMatch(input);
      expect(getGroups(match), ['oct', '1', '7', null, 'pm']);
    });

    test('should match "MARCH 20\\n7 PM"', () {
      final input = 'MARCH 20\n7 PM';
      expect(re.hasMatch(input), true);
      expect(re.allMatches(input).length, 1);

      final match = re.firstMatch(input);
      expect(getGroups(match), ['MARCH', '20', '7', null, 'PM']);
    });

    test('should match "FRIDAY MARCH 20\\n7PM"', () {
      final input = 'MARCH 20\n7 PM';
      expect(re.hasMatch(input), true);
      expect(re.allMatches(input).length, 1);

      final match = re.firstMatch(input);
      expect(getGroups(match), ['MARCH', '20', '7', null, 'PM']);
    });
  });
}
