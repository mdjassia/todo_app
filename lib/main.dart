
import 'package:flutter/material.dart';
import 'Authentification/signUp.dart';

 main() {
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

        '/' :(context) => const SignUp(),


      },
      debugShowCheckedModeBanner: false ,
    );
  }
}


