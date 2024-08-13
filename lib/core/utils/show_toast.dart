import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        webPosition: 'center',
        timeInSecForIosWeb: 3,
        backgroundColor: chooseToastColor(state),

        textColor: Colors.white,
        fontSize: 16.0);

// +++++ Enum ++++
enum ToastState { SUCCESS, ERROR, WARNING }

// +++++ To choose state from enum ++++++
Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}