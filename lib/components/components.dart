import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Components {
  static Widget SVGIcon({required String path, Color? color, double? size}) {
    return SvgPicture.asset(path,
        width: size,
        height: size,
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        semanticsLabel: 'icon');
  }

  static String convertCurrency(
      {String? locale, required dynamic number, String? symbol}) {
    return NumberFormat.currency(
            locale: locale ?? 'vi_VN', symbol: symbol ?? 'đ')
        .format(number ?? 0)
        .toString();
  }

  static Future<dynamic> readJsonFile(String filePath) async {
    final String response = await rootBundle.loadString(filePath);
    return jsonDecode(response);
  }

  static String convertDateTimeToString(
      {required DateTime dateTime, String dateFormat = 'dd-MM-yyyy'}) {
    return DateFormat(dateFormat).format(dateTime);
  }

  static String getFormattedTimer(
      {required int ms, bool includeMillis = false}) {
    var milliseconds = ms;
    final hours = Duration(milliseconds: milliseconds).inHours;
    milliseconds -= Duration(hours: hours).inMilliseconds;
    final minutes = Duration(milliseconds: milliseconds).inMinutes;
    milliseconds -= Duration(minutes: minutes).inMilliseconds;
    final seconds = Duration(milliseconds: milliseconds).inSeconds;
    final f = NumberFormat("00");
    if (!includeMillis) {
      return "${f.format(hours)}:${f.format(minutes)}:${f.format(seconds)}";
    }
    milliseconds -= Duration(seconds: seconds).inMilliseconds;
    milliseconds = (milliseconds / 10) as int;
    return "${f.format(hours)}:${f.format(minutes)}:${f.format(seconds)}:${f.format(milliseconds)}";
  }
}
