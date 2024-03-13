import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String path;
  final int height;
  final int width;
  const DisplayImage({
    super.key,
    required this.path,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      width: width * 1.0,
      height: height * 1.0,
      fit: BoxFit.cover,
      image: ResizeImage(AssetImage(path), width: width, height: height),
    );
  }
}
