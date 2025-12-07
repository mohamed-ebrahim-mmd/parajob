/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 07/12/2025 9:14 AM
 ==================================================================
*/
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> subscribeToGeneralTopic() async {
  const String topicName = 'general';
  try {
    await FirebaseMessaging.instance.subscribeToTopic(topicName);
  } catch (e) {
    log('❌ FCM: Failed to subscribe to topic: $topicName, Error: $e');
  }
}
