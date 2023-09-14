import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/data/todo.dart';
import 'itemtodo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance ;
  final _firebaseAuth = FirebaseAuth.instance ;
  User? get currentUser => _firebaseAuth.currentUser;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
       
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
                List<Todo> isdone = [] ;
                List<Todo> isnotdone  = [];
//_AnimatedMovies = AllMovies.where((i) => i.isAnimated).toList();

                for (var doc in snapshot.data!.docs) {
                  final appt =
                  Todo.fromJson(doc.data() as Map<String, dynamic>);

                  appts.add(appt);
                  if (appt.done == true ){
                    isdone.add(appt);
                  }
                  else{
                    isnotdone.add(appt);
                  }

                }

                //isdone = appts.where((i) => i.done ==true  ).toList();
               // isnotdone = appts.where((i) => i.done ==false  ).toList() ;

                return

                    Column(
                      children: [
                        Text('Todo'),
                        isnotdone.isNotEmpty  ?
                        Expanded(
                          child: ListView.builder(
                            itemCount: isnotdone.length,
                            itemBuilder: (context, index) {
                               return ListItem(todo: isnotdone[index]) ;
                            },
                          ),

                        ): SizedBox(height: 50) ,
              Text('Done'),
              Expanded(
              child: ListView.builder(
              itemCount: isdone.length,
              itemBuilder: (context, index) {
              return ListItem(todo: isdone[index]) ;
              },
              ),)
                      ],
                    );



              }
              return  const SizedBox();
            }
          )

        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff18DAA3),
          onPressed: () {  },
          child:const  Icon(Icons.add),

        ),
      ),
    );
  }
}
