import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/data/models/music.dart';

class MusicItem extends StatelessWidget {
  const MusicItem({super.key, required this.music});

  final Music music;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 60.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      music.name,
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: AppDimens.size10),
                    Text(
                      music.author,
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
              ),
              music.isPlaying
                  ? Image(
                      image: AppImages.icMusicGif,
                      width: AppDimens.iconMediumSize)
                  : const SizedBox()
            ],
          )
        ],
      ),
    );
  }
}
