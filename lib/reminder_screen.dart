import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:reminderapp/common/dropdown.dart';
import 'package:reminderapp/common/elvated_button.dart';
import 'package:reminderapp/common/global.dart';
import 'package:reminderapp/common/local_notifications.dart';
import 'package:reminderapp/common/pallete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => ReminderScreenState();
}

class ReminderScreenState extends State<ReminderScreen> {
  String? selectedDay;
  TimeOfDay? selectedTime;
  String? selectedActivity;
  String? selectedAudioFile;
  late SharedPreferences prefs;
  List<String> reminders = [];

  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    selectedDay = daysOfWeek.first;
    selectedTime = TimeOfDay.now();
    selectedActivity = 'Wake up';
    selectedAudioFile = audioFiles[0];
    _loadSavedValues();
  }

  Future<void> _loadSavedValues() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedDay = prefs.getString('selectedDay') ?? daysOfWeek.first;
      selectedTime = TimeOfDay.fromDateTime(DateTime.parse(
          prefs.getString('selectedTime') ?? DateTime.now().toString()));
      selectedActivity = prefs.getString('selectedActivity') ?? 'Wake up';
      selectedAudioFile = prefs.getString('selectedAudioFile') ?? audioFiles[0];
    });
  }

  Future<void> _scheduleReminder() async {
    notificationCreation(
      selectedActivity ?? '',
    );
    await prefs.setString('selectedDay', selectedDay!);
    await prefs.setString('selectedTime', selectedTime.toString());
    await prefs.setString('selectedActivity', selectedActivity!);
    await prefs.setString('selectedAudioFile', selectedAudioFile!);

    final now = DateTime.now();
    final timeToRemind = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    final timeDifference = timeToRemind.difference(now);
    NotificationController.onNotificationDisplayedMethod(
      ReceivedNotification(),
    );
    Future.delayed(timeDifference, () async {
      if (selectedAudioFile != null) {
        final player = AudioPlayer();
        await player.play(UrlSource(selectedAudioFile!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Reminder'),
        backgroundColor: Pallete.accentColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomDropdownButton(
                  value: selectedDay,
                  label: 'Day of the Week',
                  items: daysOfWeek,
                  onChanged: (String? newValue) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    setState(() {
                      selectedDay = newValue;
                      prefs.setString('selectedDay', newValue!);
                    });
                  }),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('Select Time'),
                trailing: InkWell(
                  onTap: () async {
                    final now = TimeOfDay.now();
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: selectedTime ?? now,
                    );

                    if (picked != null) {
                      setState(() {
                        selectedTime = picked;
                      });
                    }
                  },
                  child: Text(
                    '${selectedTime?.hour}:${selectedTime?.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomDropdownButton(
                value: selectedActivity,
                items: activity,
                onChanged: (String? newValue) async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  setState(() {
                    selectedActivity = newValue;
                    preferences.setString('selectedactivity', newValue!);
                  });
                },
                label: 'select an activity',
              ),
              const SizedBox(
                height: 15,
              ),
              CustomDropdownButton(
                  displayAudioLabels: true,
                  value: selectedAudioFile,
                  items: audioFiles,
                  onChanged: (String? newValue) async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    setState(() {
                      selectedAudioFile = newValue;
                      preferences.setString('selcetedAudioFile', newValue!);
                    });
                  },
                  label: 'select a reminder tune'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: CommonButton(
                    text: 'Set Reminder',
                    voidCallback: () {
                      final now = DateTime.now();
                      final timeToRemind = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      );

                      final timeDifference = timeToRemind.difference(now);
                      Future.delayed(timeDifference, () {
                        notificationCreation(
                          selectedActivity ?? 'no',
                        );

                        _scheduleReminder();
                      });
                    }),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
