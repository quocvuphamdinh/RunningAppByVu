import 'package:flutter/material.dart';

Widget buttonPrimary(
    BuildContext context, String buttonText, Function()? onClick) {
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
