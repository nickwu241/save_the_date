import 'package:flutter/material.dart';

import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:save_the_date/main.dart';

class OnboardingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FancyOnBoarding(
      doneButtonText: "Done",
      skipButtonText: "Skip",
      pageList: pageList,
      onDoneButtonPressed: () => shouldOnboardSink.add(false),
      onSkipButtonPressed: () => shouldOnboardSink.add(false),
    );
  }
}

final pageList = [
  PageModel(
      color: const Color(0xFFA87CA0),
      heroAssetPath: 'assets/event.png',
      title: Text('1. Screenshot',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('Take a screenshot of an event you want to save.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/screenshot-26px.png'),
  PageModel(
      color: const Color(0xFF65B0B4),
      heroAssetPath: 'assets/event-screenshot.png',
      title: Text('2. Share',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text(
          'Share it to "Save The Date" and it\'ll add it to your calendar!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/share-24px.png'),
  PageModel(
      color: const Color(0xFF09B90BC),
      heroAssetPath: 'assets/calendar.png',
      title: Text('3. Profit',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('It\;s thhat easy.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/calendar-24px.png'),
];
