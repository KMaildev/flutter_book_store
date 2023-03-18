import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  final ImagePicker picker = ImagePicker();
  String? path;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Image'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  var img = await picker.pickImage(source: ImageSource.gallery);
                  path = img?.path;
                  setState(() {});
                },
                child: const Text("Choose Image"),
              ),
              path == null
                  ? const Icon(Icons.image_not_supported_outlined)
                  : SizedBox(
                      width: 300,
                      height: 200,
                      child: Image.file(File(path!)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
