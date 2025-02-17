import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize Local Notifications
  static Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings androidInitialization =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // App icon

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitialization);

    await _localNotificationsPlugin.initialize(initializationSettings);
  }

  // Show Local Notification
  static Future<void> showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel name
      channelDescription: 'This channel is for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? "No title",
      message.notification?.body ?? "No body",
      notificationDetails,
    );
  }

  // Background Handler
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling background message: ${message.messageId}');
  }

  // Foreground Notification Listener
  static void setupFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received while in the foreground!');
      print('Message data: ${message.data}');

      // Display local notification when in the foreground
      showLocalNotification(message);

      if (message.notification != null) {
        print('Notification title: ${message.notification?.title}');
        print('Notification body: ${message.notification?.body}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked and app opened!');
      print('Message data: ${message.data}');
    });
  }

  // Get FCM Token
  static Future<void> getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print('FCM Token: $token');
    } else {
      print('Failed to get FCM Token');
    }
  }

  // Request Notification Permissions (for iOS)
  static Future<void> requestNotificationPermissions() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  // Initialize Firebase Messaging
  static Future<void> initializeFirebaseMessaging() async {
    // Initialize local notifications
    await initializeLocalNotifications();

    // Request permissions for iOS
    await requestNotificationPermissions();

    // Get FCM Token
    await getFCMToken();

    // Background Handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Setup Foreground Listeners
    setupFCMListeners();
  }
}
