package io.github.anhndt.nativeutils.flutternativeutils;

import android.content.Context;
import android.os.Build;
import android.view.Gravity;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class FlutterNativeUtilsPlugin implements MethodCallHandler {

    private static final String METHOD_CHANNEL = "io.github.anhndt_flutter_native_utils";

    private Context mContext = null;
    private static final String CHANNEL_APP_VERSION = "getPlatformVersion";
    private static final String CHANNEL_SHOW_TOAST = "showToast";

    public FlutterNativeUtilsPlugin(Context context) {
        mContext = context;
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), METHOD_CHANNEL);
        channel.setMethodCallHandler(new FlutterNativeUtilsPlugin(registrar.context()));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case CHANNEL_APP_VERSION:
                result.success("Android " + Build.VERSION.CODENAME);
                break;
            case CHANNEL_SHOW_TOAST:
                showToast(call);
                break;
            default:
                result.notImplemented();
                break;
        }

    }

    private void showToast(MethodCall call) {
        String text = call.argument("msg");
        Toast toast = Toast.makeText(mContext, text, Toast.LENGTH_SHORT);
        toast.setGravity(Gravity.TOP, 0, 0);
        toast.show();
    }
}
