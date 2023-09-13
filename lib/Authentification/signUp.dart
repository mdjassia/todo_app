
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool show = true ;
  bool hasAccount  = true ;
  final TextEditingController _controllerEmail = TextEditingController() ;
  final TextEditingController _controllerPassWord = TextEditingController() ;
  String errorMessage = '' ;

  Future<void> signInUserWithEmailPassword() async{

    try{
      await Auth().signInUserWithEmailAndPassword(
          email : _controllerEmail.text ,
          password : _controllerPassWord.text
      );
    } on FirebaseAuthException catch (e){
      setState(() {
        errorMessage = e.message!;
      });
    }
  }
  Future<void> createUserWithEmailPassword() async{

    try{
      await Auth().createUserWithEmailAndPassword(
        email : _controllerEmail.text ,
        password : _controllerPassWord.text,

        //photo: _controllerPhoto.text
      );
    } on FirebaseAuthException catch (e){
      setState(() {
        errorMessage = e.message!;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/7.png", height: 350,),
              Container(
                margin:const EdgeInsets.symmetric(vertical:10  , horizontal:20 ) ,
                child: TextField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white,
                    prefixIcon: const Icon( Icons.email_outlined , color: Colors.grey,),
                    hintText: "Email ",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) ),
                    focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Color(0xff18DAA3) , width:2 ),borderRadius: BorderRadius.circular(20)  ),

                  ),
                ),
              ),
              Container(
                margin:const EdgeInsets.symmetric(vertical:10  , horizontal:20 ) ,
                child: TextField(
                  controller: _controllerPassWord,
                  obscureText: show,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                   fillColor: Colors.white,
                    hintStyle:const TextStyle(color: Colors.grey) ,
                    prefixIcon: IconButton(
                        icon: show== true  ? const Icon( Icons.vpn_key_outlined , color: Colors.grey,) : const Icon( Icons.vpn_key_off_outlined , color: Colors.grey,) ,
                      onPressed: (){
                          setState(() {
                            show = !show ;
                          });
                      },
                    ),
                    hintText: "Password Confirm ",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) ),
                    focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color : Color(0xff18DAA3) , width:2 ),borderRadius: BorderRadius.circular(20)  ),

                  ),
                ),
              ),
              Container(
                margin:const EdgeInsets.symmetric(vertical:0  , horizontal:20 ) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text( hasAccount ? " Don't have an account ?" : "have an account already ?" , style: TextStyle(color: Colors.grey.shade700),) ,
                    TextButton(onPressed: (){ setState(() {
                      hasAccount = !hasAccount ;
                    });}, child: Text( hasAccount ? "SignUp" : "SignIn" , style: const TextStyle(fontSize: 16 , fontWeight:FontWeight.bold),))
                  ],
                ),

              ),
              Container(
                width: double.infinity,
                height: 55,
                margin:const EdgeInsets.symmetric(vertical:0  , horizontal:20 ) ,
                child: ElevatedButton(
                  style: ButtonStyle(
                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20)),
                  ),

                    backgroundColor: MaterialStateProperty.all(const Color(0xff18DAA3))
                  ),
                  onPressed: (){
                    if (hasAccount) {
                      signInUserWithEmailPassword() ;
                    }else {
                      createUserWithEmailPassword();
                    }
                  },
                  child: Text(hasAccount ? "Login" : "Sign Up" , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
