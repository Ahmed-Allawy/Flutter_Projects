// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomato_classification/ui/prediction_screen.dart';

class ImageClassification extends StatefulWidget {
  const ImageClassification({super.key});

  @override
  State<ImageClassification> createState() => __ImageClassificationStateState();
}

class __ImageClassificationStateState extends State<ImageClassification> {
  ImagePicker picker = ImagePicker();
  late ImageProvider selectedImage;
  String path = 'assets/images/default_image.PNG';
  File? _imageFile;

  Future<void> pickImageFromGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        selectedImage = FileImage(File(pickedImage.path));
        path = '';
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        selectedImage = FileImage(File(pickedImage.path));
        path = '';
      });
    }
  }

  void selectAnotherImage() {
    setState(() {
      selectedImage = const AssetImage('assets/images/default_image.PNG');
      path = 'assets/images/default_image.PNG';
    });
  }

  @override
  void initState() {
    super.initState();
    selectedImage = const AssetImage('assets/images/default_image.PNG');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 60.0),
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(157, 204, 196, 196)),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Image(
                image: selectedImage,
                fit: BoxFit.fill,
              ),
              //  const Center(
              //     child: Text(
              //   'No image selected yet !',
              //   style: TextStyle(
              //       color: Color.fromARGB(147, 161, 152, 152), fontSize: 20),
              // )),
            ),
            path == 'assets/images/default_image.PNG'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: 'Load image from gallery',
                        onTap: pickImageFromGallery,
                      ),
                      CustomButton(
                        text: 'Caputer image with camera',
                        onTap: pickImageFromCamera,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: 'Predict image',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ModelPrediction(
                                        imageFile: _imageFile,
                                      ))));
                        },
                      ),
                      CustomButton(
                        text: 'Select another image',
                        onTap: selectAnotherImage,
                      ),
                    ],
                  )
          ],
        ),
      )),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(197, 215, 206, 206)),
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(32, 139, 223, 247)),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
