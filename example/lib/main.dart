import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_native_utils/flutter_native_utils.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterNativeUtils.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

   showToast()  {
    try {
      FlutterNativeUtils.showToast(msg: "hello");
//        FlutterNativeUtils.showToast(msg: 'Heddllo',backgroundColor: "#C70039", gravity: ToastGravity.TOP, isFullWidth: true, textColor: "#ffffff", toastLength: Toast.LENGTH_SHORT);
    } on PlatformException {
      print('Failed to get platform version.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Running on: $_platformVersion\n'),
              new FlatButton(onPressed: showToast, child: new Text('Show toast'))
            ],
          )
        ),
      ),
    );
  }
}
