import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar {
  static AppBar translucentStatusAppBar = AppBar(
    elevation: 0,
    toolbarHeight: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
}
