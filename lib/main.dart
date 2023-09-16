
import 'package:flutter/material.dart';
import 'package:todo_app/Authentification/editUser.dart';
import 'package:todo_app/Home/home.dart';
import 'package:todo_app/Home/updateTodo.dart';
import 'Authentification/signUp.dart';
import 'Authentification/widgetTree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Home/addTodo.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return  MaterialApp(
      // home: signUp(),
      initialRoute: '/',
      routes: {

        '/' :(context) => const Widget_Tree(),
        '/Home' : (context) => const Home() ,
        '/register' : (context) => const SignUp(),
        '/addTodo' : (context) => const AddTodo(),
        '/editUser' : (context) => const EditUser(),




      },
      debugShowCheckedModeBanner: false ,
    );
  }
}


