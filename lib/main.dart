import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:reminderapp/common/local_notifications.dart';
import 'package:reminderapp/common/pallete.dart';
import 'package:reminderapp/reminder_screen.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: 'basic_channel_key',
        channelKey: 'basic_channel',
        channelName: 'basic',
        channelDescription: 'reminder')
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'basic_chanel_key', channelGroupName: 'reminders')
  ]);
  bool isAllowedToSendNoficiations =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNoficiations) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Pallete.accentColor),
      home: const ReminderScreen(),
    );
  }
}
