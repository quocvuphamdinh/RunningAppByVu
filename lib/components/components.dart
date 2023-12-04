import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:running_app_flutter/constant/data_run_types.dart';

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

  static String convertDateTimeMilliesToString(
      {required int ms, String dateFormat = 'dd-MM-yyyy'}) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(ms);
    return DateFormat(dateFormat).format(dateTime);
  }

  static String getFormattedTimer(
      {required int ms,
      bool includeHour = false,
      bool includeMinute = false,
      bool includeSecond = false,
      bool includeMillis = false}) {
    var milliseconds = ms;
    final hours = Duration(milliseconds: milliseconds).inHours;
    milliseconds -= Duration(hours: hours).inMilliseconds;
    final minutes = Duration(milliseconds: milliseconds).inMinutes;
    milliseconds -= Duration(minutes: minutes).inMilliseconds;
    final seconds = Duration(milliseconds: milliseconds).inSeconds;
    final f = NumberFormat("00");
    //String formattedTimer = "";
    List<String> formattedTimers = [];
    if (includeHour) {
      //formattedTimer += f.format(hours);
      formattedTimers.add(f.format(hours));
    }
    if (includeMinute) {
      //formattedTimer += ":${f.format(minutes)}";
      formattedTimers.add(f.format(minutes));
    }
    if (includeSecond) {
      //formattedTimer += ":${f.format(seconds)}";
      formattedTimers.add(f.format(seconds));
    }
    milliseconds -= Duration(seconds: seconds).inMilliseconds;
    milliseconds = milliseconds ~/ 10;
    if (includeMillis) {
      //formattedTimer += ":${f.format(milliseconds)}";
      formattedTimers.add(f.format(milliseconds));
    }
    return formattedTimers.isEmpty //formattedTimer.isEmpty
        ? "${f.format(hours)}:${f.format(minutes)}:${f.format(seconds)}"
        : formattedTimers.join(":"); //formattedTimer;
  }

  static String getFormattedTimerWithOption(
      {required int ms, required OptionTimer option}) {
    var milliseconds = ms;
    final hours = Duration(milliseconds: milliseconds).inHours;
    milliseconds -= Duration(hours: hours).inMilliseconds;
    final minutes = Duration(milliseconds: milliseconds).inMinutes;
    milliseconds -= Duration(minutes: minutes).inMilliseconds;
    final seconds = Duration(milliseconds: milliseconds).inSeconds;
    final f = NumberFormat("00");
    milliseconds -= Duration(seconds: seconds).inMilliseconds;
    milliseconds = milliseconds ~/ 10;
    if (option == OptionTimer.HOUR) {
      return f.format(hours);
    } else if (option == OptionTimer.MINUTE) {
      return f.format(minutes);
    } else if (option == OptionTimer.SECOND) {
      return f.format(seconds);
    } else if (option == OptionTimer.MILLISECOND) {
      return f.format(milliseconds);
    }
    return "${f.format(hours)}:${f.format(minutes)}:${f.format(seconds)}:${f.format(milliseconds)}";
  }
}
