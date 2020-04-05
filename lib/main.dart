import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool eventAdded = false;

  @override
  void initState() {
    super.initState();

    // addToCalendar('test', DateTime(2020, 4, 7, 12), DateTime(2020, 4, 7, 13))
    //     .then(handleAddToCalendar);
  }

  void handleAddToCalendar(bool eventAdded) {
    setState(() {
      this.eventAdded = eventAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save The Date',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Save The Date'),
        ),
        body: Center(
          child: eventAdded
              ? Text('Event successfully added to calendar!')
              : Text('Event failed to add to calendar.'),
        ),
      ),
    );
  }
}
