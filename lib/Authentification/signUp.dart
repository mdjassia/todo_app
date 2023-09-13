
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool show = true ;
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
                margin:EdgeInsets.symmetric(vertical:10  , horizontal:20 ) ,
                child: TextField(
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
                margin:EdgeInsets.symmetric(vertical:10  , horizontal:20 ) ,
                child: TextField(
                  obscureText: show,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                   fillColor: Colors.white,
                    hintStyle:TextStyle(color: Colors.grey) ,
                    prefixIcon: IconButton(
                        icon: show== true  ? Icon( Icons.vpn_key_outlined , color: Colors.grey,) :Icon( Icons.vpn_key_off_outlined , color: Colors.grey,) ,
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
                margin:EdgeInsets.symmetric(vertical:0  , horizontal:20 ) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("D'ont have an account ?" , style: TextStyle(color: Colors.grey.shade700),) ,
                    TextButton(onPressed: (){}, child: Text("Sign Up" , style: TextStyle(fontSize: 16 , fontWeight:FontWeight.bold),))
                  ],
                ),

              ),
              Container(
                width: double.infinity,
                height: 55,
                margin:EdgeInsets.symmetric(vertical:0  , horizontal:20 ) ,
                child: ElevatedButton(
                  style: ButtonStyle(
                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20)),
                  ),

                    backgroundColor: MaterialStateProperty.all(Color(0xff18DAA3))
                  ),
                  onPressed: (){

                  },
                  child: Text("Login" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
