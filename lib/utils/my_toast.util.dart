import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:parkingold/resources/colors.dart';

class MyToast {
  static void show(String? msg, {int duration = 2000, Color? backgroundColor, ToastPosition? position, double fontSize = 15}) {
    if (msg == null) {
      return;
    }
    showToast(msg,
        duration: Duration(milliseconds: duration),
        dismissOtherToast: true,
        position: position ?? ToastPosition.bottom,
        backgroundColor: backgroundColor,
        textStyle: TextStyle(
          fontSize: fontSize,
          color: Colours.white
        ));
  }

  static void cancelToast() {
    dismissAllToast();
  }
}
