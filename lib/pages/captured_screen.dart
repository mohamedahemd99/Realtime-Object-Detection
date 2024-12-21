import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:object_detection_app/app/app_resources.dart';
import 'package:object_detection_app/app/app_router.dart';
import 'package:object_detection_app/app/base/base_stateful.dart';
import 'package:object_detection_app/models/recognition.dart';
import 'package:object_detection_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

import '../services/navigation_service.dart';

class CapturedScreen extends StatefulWidget {
  const CapturedScreen({super.key, this.recognition, this.image});

  final Recognition? recognition;
  final Uint8List? image;

  @override
  State<StatefulWidget> createState() {
    return _CapturedScreenState();
  }
}

class _CapturedScreenState extends BaseStateful<CapturedScreen, HomeViewModel> {
  @override
  void afterFirstBuild(BuildContext context) {
    super.afterFirstBuild(context);
  }

  String? _selectedObject;

  @override
  void initState() {
    _selectedObject = widget.recognition!.detectedClass;
    super.initState();
  }

  @override
  AppBar buildAppBarWidget(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: AppColors.blue,
      title: Text(
        AppStrings.title,
        style: AppTextStyles.boldTextStyle(
            color: AppColors.white, fontSize: AppFontSizes.large),
      ),
      actions: [],
    );
  }

  @override
  Widget buildPageWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<NavigationService>(context, listen: false)
            .pushReplacementNamed(
          AppRoute.homeScreen,
          args: {'selectedLabel': _selectedObject},
        );

        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: buildAppBarWidget(context),
        body: buildBodyWidget(context),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.setNavigatedToCapture(false);
  }

  @override
  Widget buildBodyWidget(BuildContext context) {
    return contentWidget();
  }

  Widget contentWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.blue.withOpacity(0.4),
          border: Border.all(color: AppColors.blue, width: 2)),
      child: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: Transform.rotate(
                  angle: pi / 2,
                  child: Image.memory(
                    widget.image!,
                  ),
                )),
          ),
          Card(
            margin: EdgeInsets.all(16.0),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '“Detecting ${widget.recognition!.detectedClass ?? ''}“',
                    style: AppTextStyles.boldTextStyle(
                        color: AppColors.white, fontSize: AppFontSizes.large),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'confidence%: ${((widget.recognition!.confidenceInClass ?? 0) * 100).toStringAsFixed(0)}%}',
                    style: AppTextStyles.boldTextStyle(
                        color: AppColors.blue, fontSize: AppFontSizes.medium),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Date: ${widget.recognition!.date}',
                    style: AppTextStyles.boldTextStyle(
                        color: AppColors.grey, fontSize: AppFontSizes.medium),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Timestamp: ${widget.recognition!.timestamp}',
                    style: AppTextStyles.boldTextStyle(
                        color: AppColors.grey, fontSize: AppFontSizes.medium),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
