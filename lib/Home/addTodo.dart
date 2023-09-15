import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todo_app/data/todo.dart';
import 'package:intl/intl.dart';

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
  TextEditingController timeinput = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  Future<void> addTo()async{
    String title = _controllerTtile.text ;
    String subtitle = _controllerSubtitle.text ;
    final docRef = _firestore.collection('Todo').doc();

    Todo appt =
    Todo(id : docRef.id, email: currentUser?.email as String , date: '${dateinput.text}  ${timeinput.text}  ', title : title , subtitle: subtitle , done : false );

    await docRef.set(appt.toJson()).then(
            (value) => log("bien ajouter "),
        onError: (e) => log("Error booking appointment: $e"));
  }

  void initState() {

    timeinput.text = ""; //set the initial value of text field
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }
   String couleur = "#4f459e";
  final String hexColor = "#4f459e";
  final String hexColor2 = "#f5962a";

  
  @override
  Widget build(BuildContext context) {

    final Color color = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
    final Color color2 = Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);
    final Color color3 = Color(int.parse(couleur.substring(1, 7), radix: 16) + 0xFF000000);
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor:color ,
          title:  Text("Let's Create ur Task " , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w300),),
        ),
        body: SingleChildScrollView(

          padding: EdgeInsets.symmetric(vertical: 50 , horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [

                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,

                  child: TextFormField(


                    controller: _controllerTtile ,
                    decoration: InputDecoration(
                      enabledBorder:   OutlineInputBorder(
                          borderSide:   BorderSide(
                              color: couleur == "#4f459e" ?  Colors.grey : color3   , style: BorderStyle.solid , width: 1
                          ) , borderRadius: BorderRadius.circular(20)
                      ) ,
                      hintText: 'Title' ,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) ),
                      focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Color(0xff18DAA3) , width:2 ),borderRadius: BorderRadius.circular(20)  ),
                      hintStyle:const TextStyle(color: Colors.grey) ,


                    ),

                  ),
                ),

                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    //height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(



                            child: TextField(
                            controller: timeinput, //editing controller of this TextField
                            decoration: InputDecoration(

                                focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Colors.grey , width:1 ),borderRadius: BorderRadius.circular(20)  ),

                                //alignLabelWithHint:true ,

                                enabledBorder: OutlineInputBorder(
                                    borderSide: const  BorderSide(
                                        color: Colors.grey , style: BorderStyle.solid , width: 1
                                    ) , borderRadius: BorderRadius.circular(20)
                                ),
                                isDense: true ,
                                //focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Colors.white , width:1 ),borderRadius: BorderRadius.circular(30)  ),

                                prefixIcon:Icon(Icons.timer) ,
                                //icon of text field
                                hintText: "Enter Time" //label text of field
                            ),
                            readOnly: true,  //set it true, so that user will not able to edit text
                            onTap: () async {
                              TimeOfDay? pickedTime =  await showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );

                              if(pickedTime != null ){
                                String selTime =
                                    pickedTime.hour.toString() + ':' + pickedTime.minute.toString() ;

                                //output 14:59:00
                                //DateFormat() is from intl package, you can format the time on any pattern you need.

                                setState(() {
                                  timeinput.text = selTime; //set the value of text field.
                                });
                              }
                            },





                          ),
                        ),
                        SizedBox(width: 20,),


                         // padding: EdgeInsets.only(left: 10),
                          Expanded(

                            child: TextField(
                              controller: dateinput, //editing controller of this TextField
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Colors.grey , width:1 ),borderRadius: BorderRadius.circular(20)  ),
                                  alignLabelWithHint:true ,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const  BorderSide(
                                          color: Colors.grey , style: BorderStyle.solid , width: 1
                                      ) , borderRadius: BorderRadius.circular(20)
                                  ),
                                  isDense: true ,
                                  //focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Colors.white , width:1 ),borderRadius: BorderRadius.circular(30)  ),

                                  prefixIcon:Icon(Icons.calendar_today) ,
                                  //icon of text field
                                  hintText: "Enter date" //label text of field
                              ),
                              readOnly: true,  //set it true, so that user will not able to edit text
                              onTap: () async {
    DateTime? pickedDate = await showDatePicker(
    context: context, initialDate: DateTime.now(),
    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2101)
    );

    if(pickedDate != null ){
    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    print(formattedDate); //formatted date output using intl package =>  2021-03-16
    //you can implement different kind of Date Format here according to your requirement

    setState(() {
    dateinput.text = formattedDate; //set output date to TextField value.
    });
    }else{
    print("Date is not selected");
    };

                                },

                            ),

                        ),
                      ],
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




                Container(
                  height: MediaQuery.of(context).size.height  /3 ,

                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(

                        onPressed: (){
                          if (_controllerTtile.text.isNotEmpty){
                            addTo();
                            Navigator.pop(context);
                          }
                          else
                            setState(() {
                              couleur =  "#ff0000" ;
                            });
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            ),
                            backgroundColor: MaterialStateProperty.all(color2)
                        ),
                        child: Text("Commit" , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }}