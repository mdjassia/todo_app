import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/data/todo.dart';

import 'package:todo_app/Authentification/Auth.dart';
import 'screenTodo.dart';
import 'settings.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance ;
  final _firebaseAuth = FirebaseAuth.instance ;
  User? get currentUser => _firebaseAuth.currentUser;
  bool _isSet = false ;

  Future<void> signOut ()async{
    await Auth().signOut();
  }
  final String hexColor = "#4f459e";
  int _selectedIndex = 0;

  @override

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  Widget build(BuildContext context) {
    final Color color = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

    return
       Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0.1,
          shadowColor: Colors.grey.shade100,
          backgroundColor:color,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55.0),
            child: Container(
              margin: EdgeInsets.only(  bottom:10 , right: 20 ,left:20 ),

              width: double.infinity,
              height:55,

              color: color,

                  child: TextField(

                    style: TextStyle(color: Colors.white),

                    decoration: InputDecoration(


                      filled: true,
                      hintStyle: TextStyle(color: Colors.white54 ,),
                      focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Colors.white , width:1 ),borderRadius: BorderRadius.circular(30)  ),
                      hintText: 'Search task',
                        prefixIcon: const Icon(Icons.search , color: Colors.white, size: 30,),
                      border: OutlineInputBorder(
                          borderSide: const  BorderSide(
                            color: Colors.white , style: BorderStyle.solid , width: 1
                          ) , borderRadius: BorderRadius.circular(30)
                      ),
                      //alignLabelWithHint:true ,

                      enabledBorder: OutlineInputBorder(
                          borderSide: const  BorderSide(
                              color: Colors.white , style: BorderStyle.solid , width: 1
                          ) , borderRadius: BorderRadius.circular(30)
                      ),
                      isDense: true
                    ),

                ),
              ),

          ),


          automaticallyImplyLeading: false,

          title: Text("Welcome ${currentUser?.displayName} " , style: TextStyle(color: Colors.white , fontWeight: FontWeight.w300 ,fontSize:22 ),),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){

            },
                icon: Icon(Icons.notifications , color: Colors.white,)),
           /* IconButton(onPressed: (){
              signOut();
            },
                icon: Icon(Icons.logout , color: Colors.red.shade300,)),*/
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical:10 , horizontal:20 ),
          child: StreamBuilder(
            stream: _fireStore
                .collection('Todo')
                .where('email' , isEqualTo : currentUser?.email)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot ){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data == null) {
                return  Text(" tth ${currentUser?.email!}");
              }

              if (snapshot.data!.docs.isEmpty) {
                return SizedBox(
                  child: Center(
                      child:
                      Text("You haven't created  any appointment for $currentUser?!")),
                );
              }

              if (snapshot.hasData) {
                List<Todo> appts = [];
                List<Todo> isdone = [];
                List<Todo> isnotdone = [];

//_AnimatedMovies = AllMovies.where((i) => i.isAnimated).toList();

                for (var doc in snapshot.data!.docs) {
                  final appt =
                  Todo.fromJson(doc.data() as Map<String, dynamic>);

                  appts.add(appt);
                  if (appt.done == true) {
                    isdone.add(appt);
                  }
                  else {
                    isnotdone.add(appt);
                  }
                }
                final List<Widget> _widgetOptions = <Widget>[
                  ScreenTodo(list: isnotdone),
                  ScreenTodo(list: isdone),
                  SettingsPage()

                ];


                return _widgetOptions.elementAt(_selectedIndex);
              }
              return  const SizedBox();
            }
          )
        ),
           bottomNavigationBar: Container(
               height: 70,
               decoration:  const BoxDecoration(

                 boxShadow: [
                   BoxShadow(color: Colors.black12 , spreadRadius: 0, blurRadius: 2, blurStyle : BlurStyle.outer),
                 ],
               ),
               child:ClipRRect(


                   child:  BottomNavigationBar(
                     currentIndex: _selectedIndex,
                     backgroundColor: Colors.white,
                     selectedItemColor:color,
                     //selectedIconTheme: const IconThemeData(color: Colors.  , ),
                     selectedLabelStyle:TextStyle(fontWeight: FontWeight.w200 , fontSize:  16, height: 1.5) ,


                     onTap: _onItemTapped,
                     type: BottomNavigationBarType.fixed,


                     items:   <BottomNavigationBarItem>[
                       BottomNavigationBarItem(
                         label: 'Task',
                         icon: Icon(Icons.paste , color: Colors.grey,),
                         activeIcon: Icon(Icons.paste , color: color,),
                       ),
                       BottomNavigationBarItem(
                           label: 'Completed Task',
                           icon: Icon(Icons.inventory_outlined),
                         activeIcon: Icon(Icons.inventory_outlined , color: color,),
                       ),
                       BottomNavigationBarItem(
                           label: 'Setting',
                           icon: Icon(Icons.settings),
                           activeIcon : Icon(Icons.settings , color: color,),
                       ),



                     ],

                   )
               )) ,
           floatingActionButton: FloatingActionButton(
          backgroundColor: color ,
          onPressed: () {
            Navigator.pushNamed(context, '/addTodo');
          },
          child:const  Icon(Icons.add),

        ),

    );
  }
}
