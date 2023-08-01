import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

import 'Colors.dart';

class ShowToast {
  void showNormalToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
        backgroundColor: const Color(0xff666666),
        textColor: AppThemeColor.pureWhiteColor,
        fontSize: 16.0);
  }

  void showLongToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
        backgroundColor: const Color(0xff666666),
        textColor: AppThemeColor.pureWhiteColor,
        fontSize: 16.0);
  }
}
