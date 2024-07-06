import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotif(
      NotificationResponse notificationResponse) async {}

  static Future<void> initialize() async {
    // Init untuk masing-masing android dan iOS
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iOSInit = DarwinInitializationSettings();

// Init settings notif
    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit, iOS: iOSInit);

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotif,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotif,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showNotif(String? title, String? body) async {
    const NotificationDetails platformChannel = NotificationDetails(
        android: AndroidNotificationDetails("channel_Id", "channel_Name",
            importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails());
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannel);
  }
}
