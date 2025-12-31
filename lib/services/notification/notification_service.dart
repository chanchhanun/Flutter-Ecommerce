import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer' as dev;

import 'package:get/get.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // android
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // ios init setting
    final DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        dev.log('onDidReceiveNotificationResponse : $response');
        if (response.payload != null) {
          Get.toNamed('/account', arguments: jsonEncode(response.payload));
          dev.log('payload : ${response.payload}');
        }
      },
    );
  }

  // create notification
  static Future<void> createNotification() async {
    try {
      // android details
      final AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('channel_id', 'channel name');
      // ios details
      final DarwinNotificationDetails iosNotificationDetails =
          DarwinNotificationDetails();

      // notification details
      final NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails,
      );

      // show notification
      await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'title',
        'body',
        notificationDetails,
        payload: 'payload',
      );

      dev.log('create notification successfully');
    } catch (e) {
      if (kDebugMode) {
        dev.log('error create notification : $e');
      }
    }
  }

  static Future<void> notificationPermission() async {
    final androidPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    }
  }
}
