import 'dart:io';
import 'dart:math';

import 'package:bidex/common/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';

class ImagePickerList extends StatefulWidget {
  const ImagePickerList(
      {super.key,
      required this.onRetrieved,
      required this.onRemoved,
      this.limit = 4});
  final Function(String) onRetrieved;
  final Function(String) onRemoved;
  final int limit;

  @override
  State<ImagePickerList> createState() => _ImagePickerListState();
}

class _ImagePickerListState extends State<ImagePickerList> {
  List<String> images = [];

  void onRetrieved(String path, int index) {
    images.add(path);
    widget.onRetrieved(path);
    setState(() {});
  }

  void onCancelled(String path) {
    images.remove(path);
    widget.onRemoved(path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1,
          mainAxisSpacing: 12,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          if (index == images.length && index != widget.limit) {
            return ImagePickerWidget(
              onRetrieved: (i) {
                onRetrieved(i, index);
              },
            );
          } else {
            return image(images[index]);
          }
        },
        itemCount: min(images.length + 1, widget.limit),
      ),
    );
  }

  Widget image(String image) {
    return Badge(
      backgroundColor: Colors.transparent,
      smallSize: 0,
      largeSize: 22,
      padding: const EdgeInsets.all(0),
      isLabelVisible: true,
      label: cancelButton(image),
      child: imageDecoration(image),
    );
  }

  Widget imageDecoration(String image) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.31),
            spreadRadius: -15,
            blurRadius: 20,
            blurStyle: BlurStyle.outer,
          )
        ],
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: FileImage(File(image)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget cancelButton(String image) {
    return GestureDetector(
      onTap: () {
        onCancelled(image);
      },
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 11,
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
