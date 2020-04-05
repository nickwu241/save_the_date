import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

import 'package:save_the_date/models.dart';
import 'package:save_the_date/parse_text.dart';

Future<ParsedImageResult> parseImageFile(File imageFile) async {
  final FirebaseVisionImage visionImage =
      FirebaseVisionImage.fromFile(imageFile);
  final TextRecognizer textRecognizer =
      FirebaseVision.instance.textRecognizer();
  final VisionText visionText = await textRecognizer.processImage(visionImage);
  _printVisionText(visionText);

  final String title = visionText.blocks.toList()[0].text;
  final calendarEvent = parseText(title: title, text: visionText.text);

  textRecognizer.close();
  return ParsedImageResult(
    imageSize: await _getImageSize(imageFile),
    visionText: visionText,
    calendarEvent: calendarEvent,
  );
}

Future<Size> _getImageSize(File imageFile) async {
  final Completer<Size> completer = Completer<Size>();

  final Image image = Image.file(imageFile);
  image.image.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(Size(
        info.image.width.toDouble(),
        info.image.height.toDouble(),
      ));
    }),
  );

  return completer.future;
}

void _printVisionText(VisionText visionText) {
  String text = visionText.text;
  print('visionText.text: ' + text);
  print('-----------');
  for (TextBlock block in visionText.blocks) {
    final Rect boundingBox = block.boundingBox;
    final List<Offset> cornerPoints = block.cornerPoints;
    final String text = block.text;
    final List<RecognizedLanguage> languages = block.recognizedLanguages;
    print('block.text: ' + text);
    print('-----------');

    for (TextLine line in block.lines) {
      // Same getters as TextBlock
      for (TextElement element in line.elements) {
        // Same getters as TextBlock
        print('element.text: ' + text);
      }
    }
  }
}
