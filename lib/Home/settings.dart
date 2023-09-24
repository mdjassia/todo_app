import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../Authentification/Auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  final _firebaseAuth = FirebaseAuth.instance ;
  User? get currentUser => _firebaseAuth.currentUser;


  Future<void> signOut ()async{
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {

    return Container();

  }
}
