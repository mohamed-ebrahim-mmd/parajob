/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 12/11/2025 3:48 PM
 ==================================================================
*/
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> requestNotificationPermission() async {
  if (Platform.isIOS) {
    // iOS — request system dialog
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  } else if (Platform.isAndroid) {
    await FirebaseMessaging.instance.requestPermission();
  }
}
