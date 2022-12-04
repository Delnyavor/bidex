import 'dart:io';

import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key, this.onRetrieved}) : super(key: key);
  final void Function(String)? onRetrieved;

  @override
  State<ImagePickerWidget> createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? imageData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration:
            imageData == null ? defaultDecoration() : displayDecoration(),
        child: AspectRatio(
          aspectRatio: 1,
          child: displayIcon(),
        ),
      ),
    );
  }

  BoxDecoration defaultDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    );
  }

  BoxDecoration displayDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.51),
          offset: const Offset(12, 12),
          spreadRadius: -12,
          blurRadius: 20,
          blurStyle: BlurStyle.outer,
        )
      ],
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(image: FileImage(imageData!), fit: BoxFit.cover),
    );
  }

  Widget displayIcon() {
    if (imageData != null) {
      return const Center(
          child: CircleAvatar(
        backgroundColor: Colors.white70,
        foregroundColor: AppColors.darkBlue,
        child: Icon(
          Icons.change_circle_outlined,
        ),
      ));
    } else {
      return const Center(child: Icon(Icons.camera_alt));
    }
  }

  void getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      imageData = File(imageFile.path);
      widget.onRetrieved!(imageFile.path);
    }
    setState(() {});
  }
}
