import 'dart:io';

import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final void Function(String) onRetrieved;
  final void Function(String)? onCancelled;
  final Icon? defaultIcon;
  final Icon? retrievedIcon;
  final bool? showRetrievedIcon;
  final bool? showCancelOption;
  final Color? defaultBackgroundColor;
  const ImagePickerWidget(
      {super.key,
      required this.onRetrieved,
      this.defaultIcon,
      this.retrievedIcon,
      this.showRetrievedIcon,
      this.showCancelOption,
      this.defaultBackgroundColor,
      this.onCancelled});

  @override
  State<ImagePickerWidget> createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? imageData;
  late double width;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width * 0.3;
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: Colors.transparent,
      smallSize: 0,
      largeSize: 22,
      padding: const EdgeInsets.all(0),
      isLabelVisible: imageData != null,
      label: cancelButton(),
      child: image(),
    );
  }

  Widget cancelButton() {
    return GestureDetector(
      onTap: () {
        final path = imageData!.path;
        widget.onCancelled!(path);

        setState(() {
          imageData = null;
        });
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

  Widget image() {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        width: width,
        constraints: const BoxConstraints(maxWidth: 200),
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
      color: widget.defaultBackgroundColor ?? Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black12),
    );
  }

  BoxDecoration displayDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.51),
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
      return Center(
          child: CircleAvatar(
        backgroundColor: Colors.white70,
        foregroundColor: AppColors.darkBlue,
        child: widget.defaultIcon ??
            const Icon(
              Icons.change_circle_outlined,
            ),
      ));
    } else {
      return Center(
          child: widget.retrievedIcon ?? const Icon(Icons.camera_alt));
    }
  }

  void getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      imageData = File(imageFile.path);
      widget.onRetrieved(imageFile.path);
    }
    setState(() {});
  }
}
