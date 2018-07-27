package io.github.anhndt.nativeutils.flutternativeutils;

import android.content.Context;
import android.graphics.Color;
import android.os.Build;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.TextView;
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
    private int mDefaultTextColor = Color.WHITE;
    private int mDefaultBackgroundColor = Color.BLACK;

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
        String message = call.argument("msg");
        String backgroundColor = call.argument("backgroundColor");
        String textColor = call.argument("textColor");
        String gravity = call.argument("gravity");
        String length = call.argument("length");
        boolean isFullWidth = call.argument("isFullWidth").equals("true") ? true : false;
        Toast toast = Toast.makeText(mContext, message, length.equals("short") ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG);

        ViewGroup toastLayout = (ViewGroup) toast.getView();
        if (toastLayout != null) {
            int actionBarHeight = getActionBarHeight();
            toastLayout.setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, toastLayout.getHeight() < actionBarHeight ? actionBarHeight : ViewGroup.LayoutParams.WRAP_CONTENT));
            toastLayout.setBackgroundColor(backgroundColor != null ? Color.parseColor(backgroundColor) : mDefaultBackgroundColor);
            toastLayout.setPadding(20, 20, 20, 20);

            TextView textView = (TextView) toastLayout.getChildAt(0);
            if (textView != null) {
                textView.setTextColor(textColor != null ? Color.parseColor(textColor) : mDefaultTextColor);
            }
        }

        int location;
        switch (gravity) {
            case "top":
                location = Gravity.TOP;
                break;
            case "center":
                location = Gravity.CENTER;
                break;
            case "bottom":
                location = Gravity.BOTTOM;
                break;
            default:
                location = Gravity.BOTTOM;
                break;
        }

        int gravities = isFullWidth ? Gravity.FILL_HORIZONTAL | location : location;
        toast.setGravity(gravities, 0, 0);
        toast.show();
    }

    public int getStatusBarHeight() {
        int result = 0;
        try {
            int resourceId = mContext.getResources().getIdentifier("status_bar_height", "dimen", "android");
            if (resourceId > 0) {
                result = mContext.getResources().getDimensionPixelSize(resourceId);
            }
        } catch (Exception e) {
        }

        return result;
    }

    public int getActionBarHeight() {
        int actionBarHeight = 0;
        try {
            TypedValue tv = new TypedValue();
            if (mContext.getTheme().resolveAttribute(android.R.attr.actionBarSize, tv, true)) {
                actionBarHeight = TypedValue.complexToDimensionPixelSize(tv.data, mContext.getResources().getDisplayMetrics());
            }
        } catch (Exception e) {
        }

        return actionBarHeight;
    }
}
