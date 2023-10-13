import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/components.dart';
import '../../config/res/app_dimen.dart';
import '../../config/res/app_image.dart';

class AppDialog {
  /// Default dialog với 1 action
  static Widget commonDialog({
    required String title,
    required String action,
    String? content,
    Function()? onPressed,
  }) {
    return CupertinoAlertDialog(
      title: Text(title.tr,
          style: Get.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.w700, fontSize: 20.sp)),
      content: Text(
        content ?? '',
        style: Get.textTheme.bodyText1,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: onPressed ??
              () {
                Get.back<void>();
              },
          child: Text(action),
        )
      ],
    );
  }

  /**
   * Dialog hiện thông báo từ hệ thống
   * iconPath: Đường dẫn icon bắt buộc file phải là svg, nếu null thì mặc định là icon success
   */
  static Dialog messageDialog(
      {String? iconPath,
      String? title,
      Widget? desc,
      double? borderRadius,
      Function()? successTap,
      Color? titleColor}) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.all(AppDimens.aBitSpacingHor),
                // margin: EdgeInsets.only(top: Constants.avatarRadius),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius ?? 10),
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 10),
                          blurRadius: 10),
                    ]),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        successTap!();
                      },
                      child: Components.SVGIcon(
                          path: iconPath ?? AppImages.success)),
                  title != null
                      ? Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: titleColor,
                            fontSize: AppDimens.largeTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox.shrink(),
                  desc != null
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: AppDimens.aBitSpacingVer),
                          child: desc,
                        )
                      : const SizedBox.shrink(),
                ])),
          ),
        ],
      ),
    );
  }

  static Dialog baseDialog(
      {required String header,
      Widget? desc,
      required Function() onCloseClick,
      Image? icon}) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _baseDialogContent(
          header: header, desc: desc, onCloseClick: onCloseClick, icon: icon),
    );
  }

  static Widget _baseDialogContent(
      {required String header,
      Widget? desc,
      required Function() onCloseClick,
      Image? icon}) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: AppDimens.lightBiggestStrokeWidth),
          margin: EdgeInsets.only(
              top: AppDimens.mediumStrokeWidth,
              right: AppDimens.memoStrokeWidth),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius:
                  BorderRadius.circular(AppDimens.lightMemoStrokeWidth),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0)),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon ??
                  Image(
                      image: AppImages.icDoneSurvey,
                      width: AppDimens.iconLargeSize),
              Padding(
                padding: EdgeInsets.all(AppDimens.smallStrokeWidth),
                child: Text(
                  header,
                  style: TextStyle(
                      fontSize: AppDimens.mediumTextSize,
                      fontWeight: FontWeight.w600),
                ),
              ),
              desc == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(
                          top: AppDimens.tinyStrokeWidth,
                          left: AppDimens.largeStrokeWidth,
                          right: AppDimens.largeStrokeWidth,
                          bottom: AppDimens.largeStrokeWidth),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius:
                              BorderRadius.circular(AppDimens.tinyStrokeWidth),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(AppDimens.smallStrokeWidth),
                            child: desc),
                      ),
                    )
            ],
          ),
        ),
        Positioned(
          right: 0.0,
          child: GestureDetector(
            onTap: () {
              onCloseClick();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: AppDimens.lightLargeStrokeWidth,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.close,
                  color: Colors.black87,
                  size: AppDimens.iconSmallestSize,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
