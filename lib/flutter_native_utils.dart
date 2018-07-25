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

  static Future<Null> showToast({@required String msg, Toast toastLength, ToastGravity gravity}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'msg': msg,
      'length': toastLength,
      'gravity': gravity,
    };

    await _channel.invokeMethod('showToast', params);
  }
}
