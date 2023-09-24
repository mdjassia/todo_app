
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/Authentification/editUser.dart';
import 'package:todo_app/Home/home.dart';
import 'package:todo_app/theme/providerTheme.dart';



import 'Authentification/signUp.dart';
import 'Authentification/widgetTree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Home/addTodo.dart';
import 'Home/notif.dart';

final navigatorkey = GlobalKey<NavigatorState>();

final lightTheme = ThemeData(


    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white
    ),

  scaffoldBackgroundColor: Colors.grey.shade100,
        primaryColor:const Color(0xFF473E85) ,
        colorScheme:  ColorScheme.light(primary:  Color(0xFF473E85) ,
            onPrimary: Colors.black38 ,
            secondary: Colors.white ,
            onPrimaryContainer: Colors.grey.shade800,
            onSecondary: Colors.black26,
            shadow :Colors.grey.withOpacity(0.2)),
        timePickerTheme: const TimePickerThemeData(
          dialBackgroundColor: Colors.white, // Couleur du cadran
          hourMinuteTextColor: Color(0xFF473E85), // Couleur du texte de l'heure et des minutes
          dayPeriodTextStyle: TextStyle(fontWeight: FontWeight.bold),
          dialHandColor :  Color(0xFF473E85),
        ),
        datePickerTheme: const DatePickerThemeData(

          headerBackgroundColor: Color(0xFF473E85),

   ),
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)  , foregroundColor:Colors.white),


);

final darkTheme = ThemeData(
    primaryColor:Colors.white,

    scaffoldBackgroundColor: Color(0xFF000000),

    appBarTheme: AppBarTheme(backgroundColor:Color(0xFF000000) ,elevation: 0),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF473E85),
      backgroundColor: Color(0xFF000000) ,
      selectedIconTheme:const IconThemeData(color : Color(0xFF473E85)),
      selectedLabelStyle: const TextStyle (color : Color(0xFF473E85)),
    ),

  colorScheme:  ColorScheme.dark(primary: Color(0xFF473E85) ,
      onPrimary:  Colors.grey.shade200,
      onSecondary: Colors.grey.shade100 ,
      secondary: Color(0xFF1A1A1C),
       onPrimaryContainer: Colors.grey.shade200,
       primaryContainer:  Color(0xffcac7e2),
       shadow :Colors.black45.withOpacity(0.5)
  ),
);

@pragma('vm:entry-point')
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Notif().scheduleTaskNotification('22-09-2023 19:27');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return
     MaterialApp(
       theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
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


