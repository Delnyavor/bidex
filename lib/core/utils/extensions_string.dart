import 'package:flutter/material.dart';

extension StringParsers on String {
  String capitaliseFirst() {
    String char = characters.first;
    return replaceRange(0, 1, char.toUpperCase());
  }
}
