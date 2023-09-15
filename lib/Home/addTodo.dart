import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/todo.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  FirebaseFirestore _firestore = FirebaseFirestore.instance ;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance ; 
  User? get currentUser  => _firebaseAuth.currentUser;
  int indexx = 0;

    String errormsg = "";
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _controllerTtile = TextEditingController() ;
  final TextEditingController _controllerSubtitle = TextEditingController() ;
  
  Future<void> addTo()async{
    String title = _controllerTtile.text ;
    String subtitle = _controllerSubtitle.text ;
    final docRef = _firestore.collection('Todo').doc();
    Todo appt =
    Todo(id : docRef.id, email: currentUser?.email as String , date: DateTime.now() , title : title , subtitle: subtitle , done : false );

    await docRef.set(appt.toJson()).then(
            (value) => log("bien ajouter "),
        onError: (e) => log("Error booking appointment: $e"));
  }
  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(

          padding: EdgeInsets.symmetric(vertical: 50 , horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(

              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: const Text("Add your todo here !!" ,
                    style:  TextStyle(
                      color: Colors.black38,
                        fontSize: 22 ,
                        fontWeight: FontWeight.bold ,
                        ),),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,

                  child: TextFormField(


                    controller: _controllerTtile ,
                    decoration: InputDecoration(
                      hintText: 'Title' ,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) ),
                      focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Color(0xff18DAA3) , width:2 ),borderRadius: BorderRadius.circular(20)  ),
                      hintStyle:const TextStyle(color: Colors.grey) ,


                    ),

                  ),
                ),
            Container(
              margin: EdgeInsets.only(bottom: 20),

              child: TextFormField(
                maxLines: 6,
                controller: _controllerSubtitle ,
                decoration: InputDecoration(
                  hintText: 'details ...' ,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) ),
                  focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Color(0xff18DAA3) , width:2 ),borderRadius: BorderRadius.circular(20)  ),
                  hintStyle:const TextStyle(color: Colors.grey) ,

                ),),
            ),
                errormsg != "" ?
                  Container(
                     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                     width: double.infinity,
                     height: 50,
                     decoration: BoxDecoration(
                       color: Colors.red.shade50,
                       border: Border.all(color: Colors.red.shade300,
                           width: 1,
                           style: BorderStyle.solid),

                     ),

                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.warning_amber_rounded,
                           color: Colors.red.shade300,),
                         Text(errormsg , style: TextStyle(color: Colors.red
                             .shade300,)),

                       ],
                     )):
                  SizedBox(),

                imagess(),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(

                            onPressed: (){
                          if (_controllerTtile.text.isNotEmpty){
                            addTo();
                            Navigator.pop(context);
                          }
                          else
                            setState(() {
                              errormsg =  " Add Title  " ;
                            });
                        },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                ),
                                backgroundColor: MaterialStateProperty.all(const Color(0xff18DAA3))
                            ),
                            child: Text("Commit" , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)),
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                ),
                                backgroundColor: MaterialStateProperty.all( Colors.red)
                            ),
                            child: Text("Cancel" , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Container imagess() {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {

          return GestureDetector(
            onTap: () {
              setState(() {
                indexx = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: indexx == index ? const Color(0xff18DAA3) : Colors.grey,
                  ),
                ),
                width: 140,
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Image.asset('assets/images/${index}.png'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );


  }

}



