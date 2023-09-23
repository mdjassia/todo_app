
import 'package:flutter/material.dart';

import 'package:todo_app/Authentification/editUser.dart';
import 'package:todo_app/Home/home.dart';



import 'Authentification/signUp.dart';
import 'Authentification/widgetTree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Home/addTodo.dart';
import 'Home/notif.dart';

final navigatorkey = GlobalKey<NavigatorState>();
@pragma('vm:entry-point')
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Notif().scheduleTaskNotification('22-09-2023 19:27');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return
     MaterialApp(
       theme: ThemeData(
         colorScheme: ColorScheme.light(primary: const Color(0xFF473E85)),
         timePickerTheme: TimePickerThemeData(
           dialBackgroundColor: Colors.white, // Couleur du cadran
           hourMinuteTextColor: Color(0xFF473E85), // Couleur du texte de l'heure et des minutes
           dayPeriodTextStyle: TextStyle(fontWeight: FontWeight.bold),
           dialHandColor :  Color(0xFF473E85),
         ),
         datePickerTheme: DatePickerThemeData(

           headerBackgroundColor: Color(0xFF473E85),

             


         )
       ),
        navigatorKey: navigatorkey,

        //home: signUp(),
        initialRoute: '/',
        routes: {

          '/' :(context) => const Widget_Tree(),
          '/Home' : (context) => const Home() ,
          '/register' : (context) => const SignUp(),
          '/addTodo' : (context) => const AddTodo(),
          '/editUser' : (context) => const EditUser(),
          '/not' : (context) => const NotificationScreen(),


        },
        debugShowCheckedModeBanner: false ,

    );
  }

}


