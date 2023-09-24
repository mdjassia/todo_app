import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/data/notifications.dart';
import 'package:todo_app/Authentification/Auth.dart';
import 'package:todo_app/theme/providerTheme.dart';
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

  bool _isSet = false ;
  Future<void> callNot(Todo todo) async{
    await Notif().scheduleTaskNotification(todo);
  }
  Future<void> signOut ()async{
    await Auth().signOut();
  }
  final String hexColor = "#4f459e";
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index == 2){
      setState(() {
        _isSet =true  ;
      });
    }
    else{
      _isSet = false  ;
    }


  }
  User? get currentUser =>  _firebaseAuth.currentUser;



  Widget build(BuildContext context) {
    final Color color = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return
       Scaffold(

        appBar: AppBar(
         elevation: 1,
          shadowColor: Colors.grey.shade100,

          bottom: PreferredSize(
            preferredSize:  _isSet ? Size.fromHeight(80.0) : const Size.fromHeight(60.0) ,
            child: Container(
              margin: EdgeInsets.only(  bottom:10 , right: 20 ,left:20 ),

              width: double.infinity,
               height: _isSet ? 80 :55,



                  child: !_isSet ?
                  TextField(

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

                ) :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:  CrossAxisAlignment.center,
                        children: [
                          Row(

                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                  color: Color(0xffec356d),
                                  borderRadius: BorderRadius.circular(100)
                                ),
                                margin: EdgeInsets.only(right: 10),
                                
                                child: Text("${currentUser?.email?.substring(0 , 1).toUpperCase()}" ,
                                  style:TextStyle(
                                    color: Colors.white ,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35
                                  ) ,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${currentUser?.displayName}" , style: TextStyle(color: Colors.white , fontSize: 22 , fontWeight: FontWeight.w600),),
                                  Text("${currentUser?.email}" ,style: TextStyle(color: Colors.white , fontSize: 15 , fontWeight: FontWeight.w300),),
                                ],
                              ),
                            ],
                          ),

                          Container(

                            decoration: BoxDecoration(
                              color: Color(0xf23d376b),
                              borderRadius: BorderRadius.circular(50)
                            ),
                              child: IconButton(onPressed: (){
                                Navigator.pushNamed(context, '/editUser');
                              },
                                  highlightColor: Colors.transparent,
                                  icon: Icon(Icons.edit , color: Colors.white,
                                  )
                              )),
                        ],
                      )
              ,
              ),

          ),


          automaticallyImplyLeading: false,

          title: Text( !_isSet ? "Welcome ${currentUser?.displayName} " : "Settings" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.w300 ,fontSize:22 ),),
          centerTitle: true,
          actions: [
            !_isSet ?
        IconButton(
        icon: Icon(
          themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        ),
         onPressed: () {
           themeProvider.toggleTheme();
         },
       ) :
            IconButton(
                onPressed: (){
                  signOut();
                },
                icon: Icon(Icons.power_settings_new , color: Colors.white,))  ,
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
                for ( var apptk in isnotdone){

                  DateTime currentDate = DateTime.now();
                  Duration tenMinutes = Duration(minutes: 10);
                  DateTime newDateTime = apptk.date.subtract(tenMinutes);

                  if(currentDate.isBefore(newDateTime) ){
                    print(apptk.date);
                    print(currentDate);
                    callNot(apptk);
                  }

                }




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
                     //backgroundColor: Colors.white,
                     //selectedItemColor:color,
                     //selectedIconTheme: const IconThemeData(color: Colors.  , ),
                     selectedLabelStyle:TextStyle(fontWeight: FontWeight.w200 , fontSize:  16, height: 1.5) ,


                     onTap: _onItemTapped,
                     type: BottomNavigationBarType.fixed,


                     items:   const <BottomNavigationBarItem>[
                       BottomNavigationBarItem(
                         label: 'Task',
                         icon: Icon(Icons.paste , ),
                         activeIcon: Icon(Icons.paste ),
                       ),
                       BottomNavigationBarItem(
                           label: 'Completed Task',
                           icon: Icon(Icons.inventory_outlined),
                         activeIcon: Icon(Icons.inventory_outlined ),
                       ),
                       BottomNavigationBarItem(
                           label: 'Setting',
                           icon: Icon(Icons.settings),
                           activeIcon : Icon(Icons.settings ,),
                       ),



                     ],

                   )
               )) ,
           floatingActionButton: !_isSet ? FloatingActionButton(
          backgroundColor: color ,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/addTodo');
          },
          child:const  Icon(Icons.add),

        ) :const  SizedBox(),

    );
  }
}
