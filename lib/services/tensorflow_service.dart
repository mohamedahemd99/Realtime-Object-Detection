import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tflite_v2/tflite_v2.dart';

class TensorFlowService {
  loadModel() async {
    try {
      Tflite.close();
      String? res;

      res = await Tflite.loadModel(
          model: 'assets/models/yolov2_tiny.tflite',
          labels: 'assets/models/yolov2_tiny.txt');

      if (kDebugMode) {
        print('loadModel: $res');
      }
    } on PlatformException {
      if (kDebugMode) {
        print('Failed to load model.');
      }
    }
  }

  Future<List<String>> loadLabels() async {
    try {
      final labelsRaw =
          await rootBundle.loadString('assets/models/yolov2_tiny.txt');
      final labels = labelsRaw
          .split('\n')
          .map((label) => label.replaceAll('\r', '')) // Remove \r
          .toList();
      return labels;
    } on PlatformException {
      if (kDebugMode) {
        print('Failed to load Labels.');
      }
      return [];
    }
  }

  close() async {
    await Tflite.close();
  }

  Future<List<dynamic>?> runModelOnFrame(CameraImage image) async {
    List<dynamic>? recognitions = <dynamic>[];
    recognitions = await Tflite.detectObjectOnFrame(
      bytesList: image.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      model: "YOLO",
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 0,
      imageStd: 255.0,
      threshold: 0.2,
      numResultsPerClass: 1,
    );
    if (kDebugMode) {
      print("recognitions: $recognitions");
    }
    return recognitions;
  }
}
