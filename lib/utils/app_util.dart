import 'package:flutter/material.dart';

class PMAppUtil {
  static keyboardDis(
    BuildContext context,
  ) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static String numFormat(int number) {
    if (number < 10) {
      return "0$number";
    }
    return "$number";
  }



  static String formatDateWithoutHour({
    required DateTime dateTime,
  }) {
    return "${dateTime.year}-${numFormat(dateTime.month)}-${numFormat(dateTime.day)}";
  }

  static String formatDate({
    required DateTime dateTime,
  }) {
    return "${dateTime.year}-${numFormat(dateTime.month)}-${numFormat(dateTime.day)} ${dateTime.hour}:${numFormat(dateTime.minute)}:${numFormat(dateTime.second)}";
  }
}
