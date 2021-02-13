package app.penniesfromheaven;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import androidx.annotation.NonNull;

import app.penniesfromheaven.BuildConfig;

import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),
                "flavor")
                .setMethodCallHandler(
                        (call, result) -> {
                            result.success(BuildConfig.FLAVOR);
                        }
                );
    }
}
