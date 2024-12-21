import '/models/recognition.dart';

class HomeViewState {
  late List<Recognition> recognitions = <Recognition>[];

  List<String>? labels;

  String? selectedObject;
  bool navigatedToCapture = false;

  int widthImage = 0;

  int heightImage = 0;

  int cameraIndex = 0;

  HomeViewState();
}
