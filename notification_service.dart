import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static Future<void> initialize() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(alert:true,badge:true,sound:true);
    await messaging.getToken();
  }
}
