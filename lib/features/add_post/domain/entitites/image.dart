import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class ApiImage {
  final String? name;
  final Uint8List? bytes;
  final String? url;

  ApiImage({this.name, this.bytes, this.url})
      : assert(
            (name == null && bytes == null) || (name != null && bytes != null));

  factory ApiImage.fromFile(File imageFile) {
    return ApiImage(
        name: path.basename(imageFile.path),
        bytes: imageFile.readAsBytesSync());
  }

  factory ApiImage.fromPath(String path) {
    var imageFile = File(path);
    return ApiImage.fromFile(imageFile);
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': name,
      'base64':
          "/9j/4AAQSkZJRgABAQEAYABgAAD/${base64Encode(bytes as List<int>)}",
    };
  }
}
