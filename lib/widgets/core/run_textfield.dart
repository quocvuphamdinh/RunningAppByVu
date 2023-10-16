import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/widgets/core/run_text_show_password.dart';

class RunTextField extends StatelessWidget {
  const RunTextField(
      {super.key,
      this.hintText,
      required this.controller,
      this.isObscureText,
      this.isHidePassword,
      this.suffixIcon,
      this.textInputType,
      this.onClickSuffixIcon});

  final String? hintText;
  final TextEditingController controller;
  final bool? isObscureText;
  final bool? isHidePassword;
  final Icon? suffixIcon;
  final TextInputType? textInputType;
  final Function()? onClickSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
        height: 50.h,
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: textInputType,
              obscureText: isHidePassword ?? false,
              controller: controller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                suffixIcon: (isObscureText ?? false)
                    ? (!(isHidePassword ?? false)
                        ? RunTextShowPassword(
                            text: "HIDE", onClick: onClickSuffixIcon)
                        : RunTextShowPassword(
                            text: "SHOW", onClick: onClickSuffixIcon))
                    : suffixIcon,
                hintText: hintText,
                contentPadding: const EdgeInsets.all(10.0),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
        ));
  }
}
