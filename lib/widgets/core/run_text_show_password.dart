import 'package:flutter/material.dart';

class RunTextShowPassword extends StatelessWidget {
  const RunTextShowPassword({super.key, required this.text, this.onClick});

  final String text;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
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
