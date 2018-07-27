import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

enum Toast {
  LENGTH_SHORT,
  LENGTH_LONG
}

enum ToastGravity {
  TOP,
  BOTTOM,
  CENTER
}

class FlutterNativeUtils {
  static const MethodChannel _channel =
  const MethodChannel('io.github.anhndt_flutter_native_utils');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Null> showToast({@required String msg, String backgroundColor, String textColor, bool isFullWidth, Toast toastLength, ToastGravity gravity}) async {

    String toast = "short";
    if(toastLength == Toast.LENGTH_LONG) {
      toast = "long";
    }

    String gravityToast = "bottom";
    if(gravity == ToastGravity.TOP) {
      gravityToast = "top";
    } else if(gravity == ToastGravity.CENTER) {
      gravityToast = "center";
    } else {
      gravityToast = "bottom";
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'msg': msg,
      'backgroundColor': backgroundColor ?? '#84bd00',
      'textColor': textColor ?? '#ffffff',
      'length': toast,
      'time': 1,
      'isFullWidth': isFullWidth ?? 'false' ? 'true' : 'false',
      'gravity':gravityToast,
    };

    await _channel.invokeMethod('showToast', params);
  }
}
