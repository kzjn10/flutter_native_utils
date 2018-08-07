#include "AppDelegate.h"
#import <Flutter/Flutter.h>
#include "GeneratedPluginRegistrant.h"
#import "UIView+Toast.h"
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    FlutterViewController* controller =
    (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* toastChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"io.github.anhndt_flutter_native_utils"
                                          binaryMessenger:controller];
    [toastChannel setMethodCallHandler:^(FlutterMethodCall* call,
                                         FlutterResult result) {
        if ([@"showToast" isEqualToString:call.method]) {
            NSString *msg = call.arguments[@"msg"];
            NSString *gravity = call.arguments[@"gravity"];
            NSString *bgColor = call.arguments[@"backgroundColor"];
            NSString *titleColor = call.arguments[@"textColor"];
            float durationTime = [call.arguments[@"time"] floatValue];
            BOOL isFullWidth = [call.arguments[@"isFullWidth"] isEqualToString:@"true"] ? true : false;
            CSToastStyle *toast = [[CSToastStyle alloc] initWithDefaultStyle];
            toast.backgroundColor = [self colorFromHexString:bgColor];
            toast.titleColor = [self colorFromHexString:titleColor];
            id defaultPosition = CSToastPositionBottom;
            if ([gravity isEqualToString:@"top"]) {
                defaultPosition = CSToastPositionTop;
            } else if ([gravity isEqualToString:@"center"]) {
                defaultPosition = CSToastPositionCenter;
            }
            toast.isFullWidth = isFullWidth;
            [self.window makeToast:msg duration:durationTime position:defaultPosition style:toast];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
