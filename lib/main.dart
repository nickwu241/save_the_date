import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:save_the_date/add_to_calendar.dart';
import 'package:save_the_date/handle_share_intent.dart';
import 'package:save_the_date/models.dart';
import 'package:save_the_date/parse_image_file.dart';
import 'package:save_the_date/widgets/onboarding_widget.dart';
import 'package:save_the_date/widgets/text_detector_painter.dart';

void main() => runApp(MyApp());

StreamController<bool> _shouldOnboardStreamController =
    StreamController.broadcast();
Stream<bool> shouldOnboardStream = _shouldOnboardStreamController.stream;
Sink<bool> shouldOnboardSink = _shouldOnboardStreamController.sink;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _shouldOnboardStream = shouldOnboardStream;
  bool _eventAdded = false;
  bool _shouldShowTextDetectOverlay = false;
  ParsedImageResult _parsedImageResult;
  File _imageFile;

  @override
  void initState() {
    super.initState();
    handleImageShare()
        .then(handleImageFile)
        .then(handleParsedImageResult)
        .then(handleEventAdded)
        .catchError(handleError);
  }

  Future<ParsedImageResult> handleImageFile(File imageFile) {
    print('handleImageFile: got image: image.path=${imageFile.path}');
    setState(() {
      _imageFile = imageFile;
      shouldOnboardSink.add(false);
    });
    return parseImageFile(imageFile);
  }

  Future<bool> handleParsedImageResult(ParsedImageResult result) {
    print('handleParsedImageResult: parsing results');
    setState(() => _parsedImageResult = result);
    if (result.calendarEvent == null) {
      throw 'failed to parse calendarEvent';
    }
    return addToCalendar(result.calendarEvent);
  }

  Future<void> handleEventAdded(bool eventAdded) {
    print('handleEventAdded: eventAdded=$eventAdded');
    setState(() => this._eventAdded = eventAdded);
    return Future.value(null);
  }

  void handleError(dynamic error) {
    print('handelError: $error');
  }

  Widget _buildImage() {
    if (_imageFile == null) {
      return Container();
    }

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.file(_imageFile).image,
          fit: BoxFit.fill,
        ),
      ),
      child: _shouldShowTextDetectOverlay && _parsedImageResult != null
          ? CustomPaint(
              painter: TextDetectorPainter(
                _parsedImageResult.imageSize,
                _parsedImageResult.visionText,
              ),
            )
          : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save The Date',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Save The Date'),
          actions: <Widget>[
            if (_parsedImageResult != null)
              IconButton(
                icon: Icon(
                  _shouldShowTextDetectOverlay
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _shouldShowTextDetectOverlay =
                        !_shouldShowTextDetectOverlay;
                  });
                },
              )
          ],
        ),
        body: StreamBuilder<bool>(
          stream: _shouldOnboardStream,
          initialData: true,
          builder: (context, snapshot) {
            if (snapshot.data) {
              return OnboardingWidget();
            }
            return _buildImage();
          },
        ),
      ),
    );
  }
}
