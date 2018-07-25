import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNativeUtils {
  static const MethodChannel _channel =
      const MethodChannel('io.github.anhndt_flutter_native_utils');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
