import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:object_detection_app/pages/choose_object_screen.dart';
import 'package:object_detection_app/pages/home_screen.dart';
import 'package:object_detection_app/pages/splash_screen.dart';
import 'package:object_detection_app/services/tensorflow_service.dart';
import 'package:object_detection_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

import '../models/recognition.dart';
import '../pages/captured_screen.dart';

class AppRoute {
  static const splashScreen = '/splashScreen';
  static const chooseObjectScreen = '/chooseObjectScreen';
  static const homeScreen = '/homeScreen';
  static const capturedScreen = '/capturedScreen';

  static final AppRoute _instance = AppRoute._private();

  factory AppRoute() {
    return _instance;
  }

  AppRoute._private();

  static AppRoute get instance => _instance;

  Route<Object>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return AppPageRoute(builder: (_) => const SplashScreen());
      case chooseObjectScreen:
        return AppPageRoute(
            appSettings: settings,
            builder: (_) => ChangeNotifierProvider(
                create: (context) => HomeViewModel(context,
                    Provider.of<TensorFlowService>(context, listen: false)),
                builder: (_, __) => const ChooseObjectScreen()));
      case homeScreen:
        String? selectedLabel;
        if (settings.arguments != null) {
          final args = settings.arguments as Map<String, dynamic>;
          if ((args['selectedLabel'] is String)) {
            selectedLabel = args['selectedLabel'];
          }
        }
        return AppPageRoute(
            appSettings: settings,
            builder: (_) => ChangeNotifierProvider(
                create: (context) => HomeViewModel(context,
                    Provider.of<TensorFlowService>(context, listen: false)),
                builder: (_, __) => HomeScreen(
                      selectedLabel: selectedLabel ?? "",
                    )));

      case capturedScreen:
        Recognition? recognition;
        Uint8List? image;
        if (settings.arguments != null) {
          final args = settings.arguments as Map<String, dynamic>;
          if ((args['recognition'] is Recognition)) {
            recognition = args['recognition'];
          }
          if ((args['image'] is Uint8List)) {
            image = args['image'];
          }
        }
        return AppPageRoute(
            appSettings: settings,
            builder: (_) => ChangeNotifierProvider(
                create: (context) => HomeViewModel(context,
                    Provider.of<TensorFlowService>(context, listen: false)),
                builder: (_, __) => CapturedScreen(
                      recognition: recognition,
                      image: image,
                    )));

      default:
        return null;
    }
  }
}

class AppPageRoute extends MaterialPageRoute<Object> {
  Duration? appTransitionDuration;

  RouteSettings? appSettings;

  AppPageRoute(
      {required super.builder, this.appSettings, this.appTransitionDuration});

  @override
  Duration get transitionDuration =>
      appTransitionDuration ?? super.transitionDuration;

  @override
  RouteSettings get settings => appSettings ?? super.settings;
}
