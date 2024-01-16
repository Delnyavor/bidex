import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class FormImage {
  final String name;
  final Uint8List data;

  FormImage({required this.name, required this.data});

  factory FormImage.fromFile(File imageFile) {
    return FormImage(
        name: path.basename(imageFile.path), data: imageFile.readAsBytesSync());
  }
}

class DataImage {
  final String url;
  DataImage({required this.url});
}
