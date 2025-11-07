import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(initializationSettings);
  }

  Future<void> scheduleAlarm(DateTime dateTime, {required String title, required String body}) async {
    final androidDetails = AndroidNotificationDetails(
      'poseup-alarm',
      'PoseUp Alarm',
      importance: Importance.max,
      priority: Priority.max,
    );

    await _plugin.show(
      dateTime.millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      NotificationDetails(android: androidDetails),
      payload: 'alarm',
    );
  }
}

