import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_one_signal_app/app_manager/permission_manager.dart';
import 'package:flutter_one_signal_app/core/config/services/service_locator.dart';
import 'package:flutter_one_signal_app/router/app_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await initDependency();
  await permissionManager.requestPermission(Permission.notification);
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("a1eb5b9a-f295-4006-b9f9-474954a184bf");
  OneSignal.Notifications.requestPermission(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.router,
    );
  }
}
