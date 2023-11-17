//handles notification
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log("Message has been received!! ${message.notification!.title}");
}

class NotificationService {
  static Future<void> initialize() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    //we can check that the settings is authorized or not
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await FirebaseMessaging.instance
          .getToken(); //token has benn came but we have to check
      if (token != null) {
        log(token);
      }

      FirebaseMessaging.onBackgroundMessage(backgroundHandler);

      log("Notifications are Initialized!!");
    }
  }
}