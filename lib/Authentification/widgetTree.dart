
import 'package:flutter/material.dart';
import 'Auth.dart';
import 'signUp.dart';
import 'package:todo_app/Home/home.dart';



class Widget_Tree extends StatefulWidget {
  const Widget_Tree({super.key});

  @override
  State<Widget_Tree> createState() => _Widget_TreeState();
}

class _Widget_TreeState extends State<Widget_Tree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context , snapshot){
        if(snapshot.hasData){
          return const Home();
        }
        else{
          return const  SignUp();
        }
      },
    );
  }
}
