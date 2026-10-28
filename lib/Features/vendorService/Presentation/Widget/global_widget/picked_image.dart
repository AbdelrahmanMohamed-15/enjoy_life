import 'dart:io';

import 'package:flutter/material.dart';

/// In edit mode the cubit stores the server URL in a `File`, which
/// `Image.file` cannot load; load URLs from the network instead.
Widget pickedImage(File file, {double? height, double? width, BoxFit? fit}) {
  if (file.path.startsWith('http')) {
    return Image.network(file.path, height: height, width: width, fit: fit);
  }
  return Image.file(file, height: height, width: width, fit: fit);
}
