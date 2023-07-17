import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bidex/common/widgets/modal_form/title.dart' as ttl;
import 'modal_form/top_section.dart';

class ImagePickerModal extends StatefulWidget {
  final void Function(String)? onRetrieved;

  const ImagePickerModal({super.key, required this.onRetrieved});

  @override
  State<ImagePickerModal> createState() => _ImagePickerModalState();
}

class _ImagePickerModalState extends State<ImagePickerModal> {
  File? imageData;

  void getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final imageFile = await picker.pickImage(source: source);
    if (imageFile != null) {
      imageData = File(imageFile.path);
      widget.onRetrieved!(imageFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [top()],
        ),
      ),
    );
  }

  Widget top() {
    return TopSection(
      children: [
        const SizedBox(height: 8),
        const ttl.Title(
          title: 'Choose an image',
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              localImageSelector(),
              cameraSelector(),
            ],
          ),
        )
      ],
    );
  }

  Widget localImageSelector() {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            getImage(ImageSource.gallery);
          },
          icon: const Icon(
            Icons.filter,
            size: 32,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Gallery',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget cameraSelector() {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            getImage(ImageSource.camera);
          },
          icon: const Icon(
            Icons.camera,
            size: 32,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Camera',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
