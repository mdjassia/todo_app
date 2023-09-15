import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Timee extends StatefulWidget {
  const Timee({super.key});

  @override
  State<Timee> createState() => _TimeeState();
}

class _TimeeState extends State<Timee> {



  TextEditingController timeinput = TextEditingController();
  @override
  void initState() {
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return
            TextField(
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
                  labelText: "Enter Time" //label text of field
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


    );

  }
}
