import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/widgets/core/run_text_show_password.dart';

class RunTextField extends StatefulWidget {
  const RunTextField(
      {super.key,
      this.hintText,
      required this.controller,
      this.isObscureText,
      this.suffixIcon,
      this.textInputType});

  final String? hintText;
  final TextEditingController controller;
  final bool? isObscureText;
  final Icon? suffixIcon;
  final TextInputType? textInputType;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: widget.textInputType,
              obscureText: isHidePassword ?? false,
              controller: widget.controller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                suffixIcon: (widget.isObscureText ?? false)
                    ? (!(isHidePassword ?? false)
                        ? RunTextShowPassword(
                            text: "HIDE", onClick: _onClickHidePassword)
                        : RunTextShowPassword(
                            text: "SHOW", onClick: _onClickHidePassword))
                    : widget.suffixIcon,
                hintText: widget.hintText,
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
