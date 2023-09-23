import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:todo_app/data/todo.dart';
import 'package:intl/intl.dart';

class UpdateTodo extends StatefulWidget {
  final Todo todo ;
  const UpdateTodo({ required this.todo ,super.key});

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {

   TextEditingController _controllerTtile = TextEditingController() ;
   TextEditingController _controllerSubtitle = TextEditingController() ;


  TextEditingController timeinput = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance ;
  String couleur = "#4f459e";
  final String hexColor = "#4f459e";
  final String hexColor2 = "#f5962a";

  void updateTodo(todo) {
    //Set updated data for selected todo
    db.collection('Todo').doc('/${todo.id}').set(todo.toJson()).then(
            (value) => log("Todo updated Successfully!"),
        onError: (e) => log("Error updating Todo: $e"));
  }
   Todo? item ;
  @override
  void initState() {
    _controllerTtile.text = widget.todo.title;
    _controllerSubtitle.text = widget.todo.subtitle;
    dateinput.text = '${widget.todo.date.day}-${widget.todo.date.month}-${widget.todo.date.year}';
    timeinput.text = '${widget.todo.date.hour}:${widget.todo.date.minute}' ;
     item = Todo(title: widget.todo.title ,email: widget.todo.email, id : widget.todo.id,subtitle: widget.todo.subtitle, date: widget.todo.date , done:widget.todo.done  );
    // TODO: implement initState
    super.initState();
  }

    @override
    Widget build(BuildContext context) {
      final Color color = Color(
          int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
      final Color color2 = Color(
          int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);
      final Color color3 = Color(
          int.parse(couleur.substring(1, 7), radix: 16) + 0xFF000000);
      return SafeArea(
        child: Scaffold(

          appBar: AppBar(
            backgroundColor: color,
            title: const Text("Let's Update ur Task ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),),
          ),
          body: SingleChildScrollView(

            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [

                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: double.infinity,

                  child: TextFormField(


                    controller: _controllerTtile,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: couleur == "#4f459e"
                                  ? Colors.grey
                                  : color3, style: BorderStyle.solid, width: 1
                          ), borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff18DAA3),
                              width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      hintStyle: const TextStyle(color: Colors.grey),


                    ),

                  ),
                ),

                Container(
                  margin: const  EdgeInsets.only(bottom: 30),
                  //height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(


                        child: TextField(
                          controller: timeinput,
                          //editing controller of this TextField
                          decoration: InputDecoration(

                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(20)),

                              //alignLabelWithHint:true ,

                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1
                                  ), borderRadius: BorderRadius.circular(20)
                              ),
                              isDense: true,
                              //focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Colors.white , width:1 ),borderRadius: BorderRadius.circular(30)  ),

                              prefixIcon: const Icon(Icons.timer),
                              //icon of text field
                              hintText: "Enter Time" //label text of field
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {

                              String kk = pickedTime.format(context);


                              DateTime parsedTime = DateFormat.Hm().parse(kk);

                              //converting to DateTime so that we can further format on different pattern.

                              String formattedTime = DateFormat('HH:mm').format(parsedTime) ;
                              //output 14:59:00
                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                              //output 14:59:00
                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                              setState(() {
                                timeinput.text =
                                    formattedTime; //set the value of text field.
                              });
                            }
                          },


                        ),
                      ),
                      const SizedBox(width: 20,),


                      // padding: EdgeInsets.only(left: 10),
                      Expanded(

                        child: TextField(
                          controller: dateinput,
                          //editing controller of this TextField
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(20)),
                              alignLabelWithHint: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1
                                  ), borderRadius: BorderRadius.circular(20)
                              ),
                              isDense: true,
                              //focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Colors.white , width:1 ),borderRadius: BorderRadius.circular(30)  ),

                              prefixIcon: const Icon(Icons.calendar_today),
                              //icon of text field
                              hintText: "Enter date" //label text of field
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if (pickedDate != null) {

                              String formattedDate = DateFormat('dd-MM-yyyy')
                                  .format(pickedDate);

                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }
                          },

                        ),

                      ),
                    ],
                  ),
                ),


                Container(
                  margin: const EdgeInsets.only(bottom: 20),

                  child: TextFormField(
                    maxLines: 6,
                    controller: _controllerSubtitle,
                    decoration: InputDecoration(
                      hintText: 'details ...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff18DAA3),
                              width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      hintStyle: const TextStyle(color: Colors.grey),

                    ),),
                ),


                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 3,

                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(

                        onPressed: () {
                          if (_controllerTtile.text.isNotEmpty) {
                            setState(() {
                              String kk ='${dateinput.text} ${timeinput.text}' ;
                              DateTime dateTime = DateFormat('dd-MM-yyyy HH:mm').parse(kk);
                              item =Todo(id: widget.todo.id, email:widget.todo.email , title: _controllerTtile.text, subtitle: _controllerSubtitle.text, date: dateTime, done: false);

                            });
                            updateTodo(item);
                            Navigator.pop(context);
                          }
                          else
                            setState(() {
                              couleur =  "#ff0000";
                            });
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            backgroundColor: MaterialStateProperty.all(color2)
                        ),
                        child: const  Text("Edit Task",
                          style:  TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20),)),
                  ),
                )
              ],
            ),
          ),
        ),

      );
    }
  }
