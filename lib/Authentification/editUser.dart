import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Auth.dart';
class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;

  Future<void>updateUserName (name)async{
    await Auth().updateUserName(name: name,);
  }
  String couleur = "#4f459e";
  final String hexColor = "#4f459e";
  final String hexColor2 = "#f5962a";
  TextEditingController _conrollerUserName = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _conrollerUserName.text = currentUser?.displayName as String;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Color color = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
    final Color color2 = Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);
    final Color color3 = Color(int.parse(couleur.substring(1, 7), radix: 16) + 0xFF000000);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:color ,
        title:  Text("Edite Profile " , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w300),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: _conrollerUserName,
          decoration: InputDecoration(
            hintText: 'details ...' ,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) ),
            focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Color(0xff18DAA3) , width:2 ),borderRadius: BorderRadius.circular(20)  ),
            hintStyle:const TextStyle(color: Colors.grey) ,

          ),
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
                      if (_conrollerUserName.text.isNotEmpty){

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

    );
  }
}
