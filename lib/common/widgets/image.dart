import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String path;
  final double height;
  final double width;
  const DisplayImage({
    Key? key,
    required this.path,
    required num height,
    required num width,
  })  : width = width * 1.0,
        height = height * 1.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      width: width,
      height: height,
      fit: BoxFit.cover,
      image: AssetImage(path),
    );
  }
}
