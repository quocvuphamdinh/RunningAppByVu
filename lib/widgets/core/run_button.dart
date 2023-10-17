import 'package:flutter/material.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class RunButton extends StatelessWidget {
  const RunButton({super.key, required this.buttonText, required this.onClick});

  final String buttonText;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(AppDimens.smallSpacingHor),
      minWidth: MediaQuery.of(context).size.width,
      height: AppDimens.buttonHeight,
      onPressed: onClick,
      child: Text(
        buttonText.toUpperCase(),
        style:
            TextStyle(color: Colors.white, fontSize: AppDimens.buttonTextSize),
      ),
      color: AppColor.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
