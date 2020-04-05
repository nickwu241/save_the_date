import 'dart:ui';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ParsedImageResult {
  Size imageSize;
  VisionText visionText;
  CalendarEvent calendarEvent;

  ParsedImageResult({this.imageSize, this.visionText, this.calendarEvent});
}

class CalendarEvent {
  String title;
  DateTime startDate;
  DateTime endDate;

  CalendarEvent({this.title, this.startDate, this.endDate});
}
