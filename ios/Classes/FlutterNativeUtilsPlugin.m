#import "FlutterNativeUtilsPlugin.h"

@implementation FlutterNativeUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"io.github.anhndt_flutter_native_utils"
            binaryMessenger:[registrar messenger]];
  FlutterNativeUtilsPlugin* instance = [[FlutterNativeUtilsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"showToast" isEqualToString:call.method]){
        NSString *msg = call.arguments[@"msg"];
        NSString *gravity = call.arguments[@"gravity"];
        NSString *durationTime = call.arguments[@"time"];

        /*
        https://github.com/Rannie/Toast-Swift
        'msg': msg,
              'backgroundColor': backgroundColor ?? '#84bd00',
              'textColor': textColor ?? '#ffffff',
              'length': toast,
              'time': 1,
              'isFullWidth': isFullWidth ?? 'false' ? 'true' : 'false',
              'gravity':gravityToast,*/

        //-------



        //----------

        result(@"done");
   }
   else {
    result(FlutterMethodNotImplemented);
  }
}

@end
