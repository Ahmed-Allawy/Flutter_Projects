import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tomato_classification/ui/response_model.dart';

import 'send_image.dart';

class ModelPrediction extends StatefulWidget {
  const ModelPrediction({super.key, required this.imageFile});

  final File? imageFile;
  @override
  State<ModelPrediction> createState() => _ModelPredictionState();
}

class _ModelPredictionState extends State<ModelPrediction> {
  ApiModel? response;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    uploadImage().then((value) {
      setState(() {
        response = ApiModel.fromJson(jsonDecode(value));
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Prediction"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const ImageClassification()))),
        ),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SfCartesianChart(
                primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Classes')),
                primaryYAxis: NumericAxis(title: AxisTitle(text: 'Prediction')),
                series: [
                  ColumnSeries<SaleData, String>(
                      dataSource: [
                        SaleData(response!.predictions[0].tagName,
                            response!.predictions[0].probability * 100),
                        SaleData(response!.predictions[1].tagName,
                            response!.predictions[1].probability * 100),
                      ],
                      xValueMapper: (SaleData salse, _) => salse.x,
                      yValueMapper: (SaleData salse, _) => salse.y,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true))
                ],
              ),
      ),
    );
  }

  Future<String> uploadImage() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.5:80/image'),
    );

    request.files.add(await http.MultipartFile.fromPath(
      'imageData',
      widget.imageFile!.path,
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      var value = await response.stream.bytesToString();

      return value;
    } else {
      return '';
    }
  }
}

class SaleData {
  SaleData(this.x, this.y);
  final String x;
  final double y;
}
