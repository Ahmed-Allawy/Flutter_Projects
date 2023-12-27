// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageClassification extends StatefulWidget {
  const ImageClassification({super.key});

  @override
  State<ImageClassification> createState() => __ImageClassificationStateState();
}

class __ImageClassificationStateState extends State<ImageClassification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            pickImageCamera();
          },
          child: const Text('Send Image'),
        ),
      ),
    );
  }

  Future<void> pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        // print("herererererere+++++++++++++++++");
      } else {
        ///read iamge as uint8list
        Uint8List imageBytes = await image.readAsBytes();

        ///decode iamge to base64 to send it to flask
        String imageBase64 = base64.encode(imageBytes);
        String header = 'data:image/jpeg;base64,';
        //here we save the path of the image ;

        sendImage((header + imageBase64)).then((value) {
          // print('value from flask is : $value');
          print('response is: $value');
        });
      }
    } on PlatformException catch (e) {
      print(
          '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++$e');
    }
  }

  Future<bool> sendImage(imageBase) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://192.168.1.5:80/image'));
    request.body = json.encode({"image": imageBase});
    print(imageBase);
    // /////////////////////////////////////
    // final Directory directory = await getApplicationDocumentsDirectory();
    // final File file = File('${directory.path}/my_file.txt');
    // print('${directory.path}/my_file.txt');
    // await file.writeAsString(imageBase);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
