import 'package:flutter/material.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class RunTextShowPassword extends StatelessWidget {
  const RunTextShowPassword({super.key, required this.text, this.onClick});

  final String text;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingVer),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onClick,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
