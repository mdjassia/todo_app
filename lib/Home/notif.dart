
import 'package:flutter/material.dart';


class NotificationScreen extends StatelessWidget {

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments.toString()  ;
    String title = message.split('|')[0] ;
    String subtitle =message.split('|')[1];
    String date = message.split('|')[2] ;

    return  SafeArea(
      child: Scaffold(
        body: Container(


          child: Stack(
            alignment: Alignment.topRight,

            children: [Container(
              margin: EdgeInsets.symmetric(vertical: 120 , horizontal: 15),
              padding:  EdgeInsets.symmetric(vertical: 20 , horizontal: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Color and opacity of the shadow
                    spreadRadius: 5, // Spread radius of the shadow
                    blurRadius: 7, // Blur radius of the shadow
                    offset: Offset(0, 3), // Offset of the shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xffcac7e2) ,style: BorderStyle.solid , width: 3 ,strokeAlign: BorderSide.strokeAlignOutside),
                color:
                Theme.of(context).colorScheme.secondary
              ),
              child: Column(
                //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reminder' ,style: TextStyle(color: Theme.of(context).primaryColor , fontSize: 40 , fontWeight: FontWeight.w700),),
                  SizedBox(height: 50,),

                   



                  Text("${title}" , style: TextStyle( color :Theme.of(context).colorScheme.onPrimaryContainer ,fontSize: 25 , fontWeight: FontWeight.w600),),
                  SizedBox(height: 15,),
                  Text( "Today at ${date} "  , style : TextStyle( color :Colors.grey,fontSize: 18 , fontWeight: FontWeight.w500),),

                  SizedBox(height: 15,),
                  Text("${subtitle}" , style: TextStyle( color :Colors.grey , fontSize: 18 , fontWeight: FontWeight.w300),),

                ],
              ),
            ),
              PositionedDirectional(
                top: 10,
                end:0,
                child:Image.asset('assets/images/66.png' ,height: 180 , width: 180,) ,)
            ]
          ),
        ),
      ),
    );
  }
}