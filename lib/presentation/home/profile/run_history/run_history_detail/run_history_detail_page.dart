import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/profile/run_history/run_history_detail/run_history_detail_controller.dart';
import 'package:running_app_flutter/presentation/result_exercise_run/widgets/result_run_data_row.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/run_text_no_data.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class RunHistoryDetailPage extends GetView<RunHistoryDetailController> {
  const RunHistoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(child: Obx(() {
        var run = controller.run.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarThreeSide(
              widgetLeft: Icon(Icons.close, size: AppDimens.iconSmallSize),
              onClickWidgetLeft: () {
                Get.delete<RunHistoryDetailController>();
                Get.back();
              },
              widgetCenter: TextTitle(
                  text: run != null
                      ? "Run - ${Components.convertDateTimeMilliesToString(ms: run.timestamp, dateFormat: 'dd/MM/yyyy')}"
                      : "Run History"),
              widgetRight: run != null
                  ? Icon(Icons.delete,
                      size: AppDimens.iconSmallSize, color: AppColor.redColor)
                  : const SizedBox(),
              onCLickWidgetRight: () {
                controller.onDeleteRun();
              },
            ),
            Expanded(
              child: run != null
                  ? ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDimens.smallSpacingHor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ResultRunDataRow(
                                icon: AppImages.icMovingTimeColor,
                                titleText: "Start Time",
                                valueText:
                                    "${Components.convertDateTimeMilliesToString(ms: run.timestamp - run.timeInMillis, dateFormat: "hh:mm:ss")} hrs",
                                valueTextColor: AppColor.distanceColor,
                              ),
                              ResultRunDataRow(
                                icon: AppImages.icDistanceColor,
                                titleText: "Distance",
                                valueText:
                                    "${run.distanceInKilometers / 1000} km",
                                valueTextColor: AppColor.distanceColor,
                              ),
                              ResultRunDataRow(
                                icon: AppImages.icCaloriesColor,
                                titleText: "Calories Burned",
                                valueText: "${run.caloriesBurned} Kcal",
                                valueTextColor: AppColor.caloriesColor,
                              ),
                              ResultRunDataRow(
                                icon: AppImages.icAvgSpeedColor,
                                titleText: "Average Speed",
                                valueText:
                                    "${run.averageSpeedInKilometersPerHour} km/h",
                                valueTextColor: AppColor.avgSpeedColor,
                              ),
                              ResultRunDataRow(
                                icon: AppImages.icDurationColor,
                                titleText: "Duration",
                                valueText: Components.getFormattedTimer(
                                    ms: run.timeInMillis,
                                    includeHour: true,
                                    includeMinute: true,
                                    includeSecond: true),
                                valueTextColor: AppColor.durationColor,
                              ),
                              SizedBox(height: AppDimens.size10),
                              GestureDetector(
                                onTap: () {
                                  if (run.img == null || run.img!.isEmpty) {
                                    return;
                                  }
                                  Get.toNamed(AppRoutes.ShowImage,
                                      arguments: {"image_url": run.img});
                                },
                                child: (run.img == null || run.img!.isEmpty)
                                    ? _runImage(AppImages.errorGif)
                                    : CachedNetworkImage(
                                        imageUrl: run.img!,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CupertinoActivityIndicator()),
                                        errorWidget: (context, url, error) =>
                                            _runImage(AppImages.errorGif),
                                        imageBuilder:
                                            ((context, imageProvider) =>
                                                _runImage(imageProvider)),
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : const RunTextNoData(),
            )
          ],
        );
      })),
    );
  }

  Widget _runImage(ImageProvider imageProvider) {
    return Container(
      height: Get.height * 0.4,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.solid,
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 5.0,
            ),
          ],
          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
    );
  }
}
