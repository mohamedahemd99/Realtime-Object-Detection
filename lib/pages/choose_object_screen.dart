import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:object_detection_app/app/app_resources.dart';
import 'package:object_detection_app/app/app_router.dart';
import 'package:object_detection_app/app/base/base_stateful.dart';
import 'package:object_detection_app/services/navigation_service.dart';
import 'package:object_detection_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';

class ChooseObjectScreen extends StatefulWidget {
  const ChooseObjectScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChooseObjectScreenState();
  }
}

class _ChooseObjectScreenState
    extends BaseStateful<ChooseObjectScreen, HomeViewModel>
    with WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;

  @override
  void afterFirstBuild(BuildContext context) {
    super.afterFirstBuild(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void initState() {
    super.initState();
    loadLabels();
  }

  void loadLabels() async {
    await viewModel.loadLabels();
  }

  @override
  Widget buildPageWidget(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: buildAppBarWidget(context),
      body: buildBodyWidget(context),
    );
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
    );
  }

  @override
  Widget buildBodyWidget(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.grey.shade900,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome to Object Detection!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.boldTextStyle(
                      color: AppColors.white, fontSize: AppFontSizes.large),
                ),
                const SizedBox(height: 30),
                Consumer<HomeViewModel>(builder: (_, homeViewModel, __) {
                  return viewModel.state.labels == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16.h),
                            Text(
                              'Loading objects...',
                              style: AppTextStyles.mediumTextStyle(
                                  color: AppColors.white,
                                  fontSize: AppFontSizes.medium),
                            ),
                          ],
                        )
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 2, color: Colors.grey)),
                          padding: EdgeInsets.all(8),
                          child: SearchChoices.single(
                            items: viewModel.state.labels!
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            value: viewModel.state.selectedObject,
                            hint: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Select an object to detect",
                                style: AppTextStyles.mediumTextStyle(
                                    color: AppColors.white,
                                    fontSize: AppFontSizes.medium),
                              ),
                            ),
                            searchHint: "Select any object",
                            onChanged: (value) {
                              viewModel.setSelectedObject(value);
                            },
                            isExpanded: true,
                          ),
                        );
                }),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: viewModel.state.selectedObject == null
                      ? null
                      : () {
                          Provider.of<NavigationService>(context, listen: false)
                              .pushNamed(
                            AppRoute.homeScreen,
                            args: {
                              'selectedLabel': viewModel.state.selectedObject
                            }, // Pass selected label
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Get Started',
                    style: AppTextStyles.mediumTextStyle(
                        fontSize: AppFontSizes.large),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
