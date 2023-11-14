import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/widgets/core/run_text_show_password.dart';

class RunTextField extends StatefulWidget {
  const RunTextField(
      {super.key,
      this.hintText,
      required this.controller,
      this.isObscureText = false,
      this.suffixIcon,
      this.textInputType,
      this.isEnabled = true});

  final String? hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final Icon? suffixIcon;
  final TextInputType? textInputType;
  final bool isEnabled;

  @override
  State<RunTextField> createState() => _RunTextFieldState();
}

class _RunTextFieldState extends State<RunTextField> {
  var isHidePassword = true;

  _onClickHidePassword() {
    setState(() {
      isHidePassword = !isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
        height: 50.h,
        width: Get.size.width,
        child: Center(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            enabled: widget.isEnabled,
            style: TextStyle(fontSize: 16.sp),
            keyboardType: widget.textInputType,
            obscureText: widget.isObscureText ? isHidePassword : false,
            controller: widget.controller,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              suffixStyle: TextStyle(fontSize: AppDimens.iconSmallSize),
              suffixIconColor: AppColor.grey,
              suffixIcon: (widget.isObscureText)
                  ? (!isHidePassword
                      ? RunTextShowPassword(
                          text: "HIDE", onClick: _onClickHidePassword)
                      : RunTextShowPassword(
                          text: "SHOW", onClick: _onClickHidePassword))
                  : widget.suffixIcon,
              hintText: widget.hintText,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 15.0.h),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ));
  }
}
