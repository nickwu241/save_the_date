import 'dart:io';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';

Future<void> handleTextShare() {
  return ReceiveSharingIntent.getInitialText().then((data) {
    print(data);
  });
}

Future<File> handleImageShare() {
  return ReceiveSharingIntent.getInitialMedia().then((data) {
    if (data == null) {
      throw 'no image file shared';
    }
    final f = File(data[0].path);
    return f;
  });
}
