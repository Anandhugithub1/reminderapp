import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

List<String> activity = [
  'Wake up',
  'Go to gym',
  'Breakfast',
  'Meetings',
  'Lunch',
  'Quick nap',
  'Go to library',
  'Dinner',
  'Go to sleep',
];
final List<String> daysOfWeek = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];
List<String> audioFiles = [
  'https://www.fesliyanstudios.com/play-mp3/4384',
  'https://www.fesliyanstudios.com/play-mp3/4391',
  'https://www.fesliyanstudios.com/play-mp3/4386',
  'https://www.fesliyanstudios.com/play-mp3/5328',
];

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> scheduleNotification(String reminderActivity) async {
  // final reminderTune = prefs.getString('selectedAudioFile');

  // await player.play(UrlSource(reminderTune!));

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'Reminder',
    importance: Importance.max,
    priority: Priority.high,
  );

  final NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Reminder',
    'Time for $reminderActivity!', // Include the reminder activity text in the notification message
    platformChannelSpecifics,
    payload: reminderActivity, // Pass the reminder activity as payload
  );
}

Future<void> initializeNotifications() async {
  // Create an instance of FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Define notification settings for Android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Define notification settings for iOS

  // Define platform-specific initialization settings
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  // Initialize the plugin with the defined settings
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
