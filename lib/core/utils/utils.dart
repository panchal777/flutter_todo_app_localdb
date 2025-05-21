import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  String generateRandomId([int length = 10]) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random.secure();
    return List.generate(
      length,
      (_) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  static void showToast({required String msg, int timeInSec = 1}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: timeInSec,
    );
  }
}
