package github.leyan95.basic_engine;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    CheckPermissionUtils.initPermission(this);
    GeneratedPluginRegistrant.registerWith(this);
  }
}
