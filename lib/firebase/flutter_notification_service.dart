import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import 'custom_app_notification.dart';


class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('app_icon');

    DarwinInitializationSettings initializationSettingsIOS =
    const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        print('Notification clicked!');
      },
    );
  }

  Future<void> showNotification({
    String title = 'Welcome!',
    String body = 'Welcome to Flowery App',
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'welcome_channel_id',
      'Welcome Notifications',
      channelDescription: 'Notifications shown when app opens',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }}
class FirebaseMessagingService {
  static final FirebaseMessagingService _instance = FirebaseMessagingService._();
  static FirebaseMessagingService get instance => _instance;

  FirebaseMessagingService._();

  static Future<void> initializeFirebaseMessaging() async {
    try {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');

        String? token = await FirebaseMessaging.instance.getToken();
        print('FCM Token: $token');

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          print('Got a message whilst in the foreground!');
          print('Message data: ${message.data}');

          if (message.notification != null) {
            print('Message also contained a notification: ${message.notification}');
            _handleForegroundMessage(message);
          }
        });

        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          print('Message opened app from background state!');
          _handleMessageOpenedApp(message);
        });

        RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
        if (initialMessage != null) {
          _handleInitialMessage(initialMessage);
        }
      } else {
        print('User declined or has not accepted permission: ${settings.authorizationStatus}');
      }
    } catch (e) {
      print('Error initializing Firebase Messaging: $e');
    }
  }

  static void _handleForegroundMessage(RemoteMessage message) {
    if (message.notification != null) {
      NotificationService().showNotification(
        title: message.notification?.title ?? 'New Notification',
        body: message.notification?.body ?? '',
      );

      if (navigatorKey.currentContext != null) {
        InAppNotification.show(
          navigatorKey.currentContext!,
          message.notification?.body ?? '',
        );
      }
    }
  }

  static void _handleMessageOpenedApp(RemoteMessage message) {
    print('Notification clicked with data: ${message.data}');
  }
  static void _handleInitialMessage(RemoteMessage message) {
    print('App opened from notification with data: ${message.data}');
  }
}

