import 'package:flutter/material.dart';

class RunButton extends StatelessWidget {
  const RunButton({super.key, required this.buttonText, this.onClick});

  final String buttonText;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(14),
      minWidth: MediaQuery.of(context).size.width * 0.6,
      onPressed: onClick,
      child: Text(
        buttonText.toUpperCase(),
        style: const TextStyle(color: Colors.white),
      ),
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
