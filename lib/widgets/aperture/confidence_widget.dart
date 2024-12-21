import 'dart:math';

import 'package:flutter/material.dart';
import 'package:object_detection_app/app/app_resources.dart';

import '../../models/recognition.dart';

class ConfidenceWidget extends StatelessWidget {
  final List<Recognition> entities;
  final String selectedObject;
  final int previewWidth;
  final int previewHeight;
  final double screenWidth;
  final double screenHeight;

  final double heightAppBar;

  const ConfidenceWidget({
    Key? key,
    required this.heightAppBar,
    required this.entities,
    required this.previewWidth,
    required this.previewHeight,
    required this.screenWidth,
    required this.screenHeight,
    required this.selectedObject,
  }) : super(key: key);

  List<Widget> _renderHeightLineEntities() {
    List<Widget> results = <Widget>[];
    if (entities.isEmpty) {
      results.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Detecting $selectedObject',
              style: AppTextStyles.regularTextStyle(
                  color: Colors.red,
                  fontSize: AppFontSizes.medium,
                  backgroundColor: AppColors.white),
            ),
          ),
        ),
      );
    } else {
      results = entities.map((entity) {
        var _x = entity.rect!.x;
        var _y = entity.rect!.y;
        var _w = entity.rect!.w;
        var _h = entity.rect!.h;

        var screenRatio = screenHeight / screenWidth;
        var previewRatio = previewHeight / previewWidth;

        var scaleWidth, scaleHeight, x, y, w, h;
        if (screenRatio > previewRatio) {
          scaleHeight = screenHeight;
          scaleWidth = screenHeight / previewRatio;
          var difW = (scaleWidth - screenWidth) / scaleWidth;
          x = (_x - difW / 2) * scaleWidth;
          w = _w * scaleWidth;
          if (_x < difW / 2) {
            w -= (difW / 2 - _x) * scaleWidth;
          }
          y = _y * scaleHeight;
          h = _h * scaleHeight;
        } else {
          scaleHeight = screenWidth * previewRatio;
          scaleWidth = screenWidth;
          var difH = (scaleHeight - screenHeight) / scaleHeight;
          x = _x * scaleWidth;
          w = _w * scaleWidth;
          y = (_y - difH / 2) * scaleHeight;
          h = _h * scaleHeight;
          if (_y < difH / 2) {
            h -= (difH / 2 - _y) * scaleHeight;
          }
        }
        return Positioned(
          left: max(0, x),
          top: max(0, y),
          width: w,
          height: h,
          child: Container(
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 2.0),
            ),
            child: Column(
              children: [
                Text(
                  '“Detecting ${entity.detectedClass ?? ''} ${((entity.confidenceInClass ?? 0) * 100).toStringAsFixed(0)}%',
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.regularTextStyle(
                      color: Colors.red,
                      fontSize: AppFontSizes.medium,
                      backgroundColor: AppColors.white),
                ),
                if (_w < 0.3 * screenWidth)
                  Text('Move closer', style: TextStyle(color: Colors.red)),
                if (_w > 0.7 * screenWidth)
                  Text('Move farther', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        );
      }).toList();
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childes = [];
    childes = _renderHeightLineEntities();
    return Stack(
      children: childes,
    );
  }
}
