import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class AppBarWithBottomTab extends StatefulWidget {
  const AppBarWithBottomTab(
      {super.key,
      required this.widgetBodies,
      required this.contentWidgetTabBars,
      this.widgetAppBarLeft,
      this.widgetAppBarRight,
      this.onClickWidgetAppBarLeft,
      this.onCLickWidgetAppBarRight,
      this.backgroundColor});

  final List<Widget> widgetBodies;
  final List<Widget> contentWidgetTabBars;
  final Widget? widgetAppBarLeft;
  final Widget? widgetAppBarRight;
  final Function()? onClickWidgetAppBarLeft;
  final Function()? onCLickWidgetAppBarRight;
  final Color? backgroundColor;

  @override
  State<AppBarWithBottomTab> createState() => _AppBarWithBottomTabState();
}

class _AppBarWithBottomTabState extends State<AppBarWithBottomTab> {
  var CURRENTTAB = 0;

  onChangeTabIndex(int tab) {
    setState(() {
      CURRENTTAB = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.all(AppDimens.aBitSpacingHor),
          height: 50.h,
          color: widget.backgroundColor ?? AppColor.appBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.widgetAppBarLeft != null
                  ? GestureDetector(
                      child: widget.widgetAppBarLeft!,
                      onTap: widget.onClickWidgetAppBarLeft,
                    )
                  : const SizedBox(),
              widget.widgetAppBarRight != null
                  ? GestureDetector(
                      child: widget.widgetAppBarRight!,
                      onTap: widget.onCLickWidgetAppBarRight,
                    )
                  : const SizedBox()
            ],
          ),
        ),
        Container(
          color: AppColor.grey80,
          height: AppDimens.size1,
        ),
        Container(
            color: AppColor.appBackgroundColor,
            height: 50.h,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.contentWidgetTabBars.map((item) {
                  var index = widget.contentWidgetTabBars.indexOf(item);
                  return Expanded(
                      child: GestureDetector(
                    onTap: () {
                      onChangeTabIndex(index);
                    },
                    child: Container(
                      color: AppColor.appBackgroundColor,
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: item,
                            ),
                          ),
                          Container(
                            height: AppDimens.size5,
                            color: CURRENTTAB == index
                                ? AppColor.grey
                                : AppColor.appBackgroundColor,
                          )
                        ],
                      ),
                    ),
                  ));
                }).toList())),
        Expanded(
            child: IndexedStack(
          index: CURRENTTAB,
          children: widget.widgetBodies,
        ))
      ],
    );
  }
}
