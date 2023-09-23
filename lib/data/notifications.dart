
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/main.dart';


class Notif {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();



Future<tz.TZDateTime> convertToTZTime (DateTime datetime) async{
  tzdata.initializeTimeZones();
  tz.Location timeZone =   tz.getLocation('Africa/Algiers');
  DateTime dateTime = DateTime(datetime.year, datetime.month, datetime.day, datetime.hour, datetime.minute);
  tz.TZDateTime tzDateTime = tz.TZDateTime.from(dateTime, timeZone);
  tz.TZDateTime newTime = tzDateTime.subtract(const Duration(minutes: 10));
  return newTime;
}
  Future<tz.TZDateTime> convertStringToTZDateTime(String dateTimeString) async {
    tzdata.initializeTimeZones();
    tz.Location timeZone =   tz.getLocation('Africa/Algiers');
      // Split the input string into date and time parts
      List<String> parts = dateTimeString.split('  ');

      // Split the date part into day, month, and year
      List<String> dateParts = parts[0].split('-');
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);

      // Split the time part into hour and minute
      List<String> timeParts = parts[1].split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);


      // Create a DateTime object
      DateTime dateTime = DateTime(year, month, day, hour, minute);


      // Convert DateTime to TZDateTime using the specified time zone
      tz.TZDateTime tzDateTime = tz.TZDateTime.from(dateTime, timeZone);
      tz.TZDateTime newTime = tzDateTime.subtract(const Duration(minutes: 10));
      return newTime;

  }




  Future<void> scheduleTaskNotification( Todo todo) async {
  print('///////////+++++++//////////////////////////////////////////////');

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      channelDescription : 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );
    final initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Remplacez par votre icône d'application

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,

    );
    await flutterLocalNotificationsPlugin.initialize( initializationSettings , onDidReceiveNotificationResponse:(NotificationResponse response) async {
      final payload = response.payload ;


         navigatorkey.currentState?.pushNamed('/not' ,arguments: payload);


    } );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,

    );

    //tz.TZDateTime tzDateTime = await convertToTZDateTime(taskTime)
    tz.TZDateTime tzDateTime = await convertToTZTime(todo.date);





    await flutterLocalNotificationsPlugin.zonedSchedule(
        todo.id,
      'Task Reminder',
      'Votre Task de ${todo.title} vas bien tot finir ',
      tzDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: '${todo.title}|${todo.subtitle}|${todo.date.hour}:${todo.date.minute}'
    );


  }
  Future<void> cancelNotif (int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}