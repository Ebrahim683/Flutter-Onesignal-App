import 'package:flutter/material.dart';
import 'package:flutter_one_signal_app/pages/home/home_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("<YOUR APP ID HERE>");
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
