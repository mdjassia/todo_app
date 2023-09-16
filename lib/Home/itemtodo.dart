import 'dart:developer';
import 'updateTodo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/todo.dart';
class ListItem extends StatefulWidget {
  final Todo todo ;

  const ListItem( {super.key, required this.todo });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
 // String hexColor = "#28dfbf" ;

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance ;
  User? get currentUser  => _firebaseAuth.currentUser;

  Future<void>checkFun (done , id )async{
    await db.collection('Todo').doc(id).update({"done" : done}).then(
            (value) => log("updated Successfully!"),
        onError: (e) => log("Error updating : $e"));
  }
  final String hexColor = "#4f459e";
  final String hexColor2 = "#399f49";
  void deleteAppointment(todo) {
    //Delete selected appointment
    db.collection('Todo').doc(todo).delete().then(
            (value) => log("Appointment deleted successfully!"),
        onError: (e) => "Error deleting appointment: $e");
  }

  @override

  Widget build(BuildContext context) {
    final Color color = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
    final Color color2 = Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);

    String id = widget.todo.id ;
    bool _isdone =  widget.todo.done;
    String    date =               widget.todo.date ;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.todo.title ,
                    style:TextStyle(color: color  , fontSize: 24 , fontWeight: FontWeight.w600) ,
                  ) ,
                  Text(date ,
                  style:TextStyle(
                    color: Colors.black26,

                  ) ,
                  )

                ],
              ) ,
              SizedBox(height: 10,),
              Text(widget.todo.subtitle ,
              style: TextStyle(
                color: Colors.black38 ,
                  //fontWeight: FontWeight.w300
                fontSize: 16
              ),),
              SizedBox(height: 20,),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0x42000000)))
                ),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade400,
                            borderRadius: BorderRadius.circular(40)
                          ),
                          child: IconButton(
                           padding: EdgeInsets.all(0),
                            onPressed : (){

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  UpdateTodo(todo: widget.todo,)),
                              );
                            } ,
                              icon: Icon(Icons.edit , color: Colors.white, size: 20,) ,



                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade800,
                            borderRadius: BorderRadius.circular(40)
                          ),
                          child: IconButton(
                           padding: EdgeInsets.all(0),
                            onPressed : (){
                              deleteAppointment(id);
                            } ,
                              icon: Icon(Icons.delete , color: Colors.white, size: 20,) ,



                          ),
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade700,
                            borderRadius: BorderRadius.circular(40)
                          ),
                          child: IconButton(

                            onPressed : (){} ,
                              icon: Icon(Icons.share , color: Colors.white, size: 20,) ,



                          ),
                        ),


                      ],
                    ),
                    !_isdone ?
                    Container(
                      height: 40,
                      child: ElevatedButton(onPressed: (){
                        setState(() {
                          _isdone = !_isdone ;
                        });
                        checkFun( _isdone ,  id);
                      },
                          child: Text('Complete'),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            ),

                            backgroundColor: MaterialStateProperty.all(color2  )
                        ),),
                    ) : SizedBox(width: 50,)
                  ],
                ),
              )
            ],

          ),
        ),
      ),
    );
  }
}