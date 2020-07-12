
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditation_app/widgets/bottom_nav_bar.dart';
import 'package:meditation_app/services/auth.dart';



class SettingScreen extends StatelessWidget {
  AuthService _authService =AuthService();
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
       title: Text('Settings',
       style:TextStyle(
         fontWeight: FontWeight.w900,
         fontFamily: 'Cairo-Black',
       ),
      ),),
     bottomNavigationBar: BottomNavBar(whichScreen:'settings'),
    
body: ListView(children: <Widget>[
  SizedBox(
    height:20.0
  ),
      Container(
        margin: EdgeInsets.symmetric(vertical:10.0 ,horizontal:8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          
          color:Colors.white,
          borderRadius: BorderRadius.circular(18.0)
        ),
        child: ListTile(
          title:Text('About us',style: TextStyle(
            fontSize:18.0,
            fontWeight: FontWeight.bold),),
          subtitle: Text('Version : ^1.0.0 \nOpen source learing application. '),
          trailing: Icon(Icons.info_outline),
        ),
      ),
       Container(
        margin: EdgeInsets.symmetric(vertical:10.0 ,horizontal:8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          
          color:Colors.white,
          borderRadius: BorderRadius.circular(18.0)
        ),
        child: ListTile(
          title:Text('FAQ\'s',style: TextStyle(
            fontSize:18.0,
            fontWeight: FontWeight.bold),),
          subtitle: Text('1.Every question is free of cost\n2.We don\'t charge any amount in any form for this application.\n3.Complete open source learning platform.'),
          trailing: Icon(Icons.info_outline),
        ),
      ),
       Container(
        margin: EdgeInsets.symmetric(vertical:10.0 ,horizontal:8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          
          color:Colors.white,
          borderRadius: BorderRadius.circular(18.0)
        ),
        child: ListTile(
          title:Center(
            child: Text('Logout',style: TextStyle(
              color: Colors.red,
              fontSize:18.0,
              fontWeight: FontWeight.bold),),
              
          ),
          onTap: (){
             
             
              _authService.signOut();
              Navigator.pushReplacementNamed(context, '/signin');
          },
          
        ),
      ),

      Center(
        child: Container(
        
          child: Text('All rights reserved @2020 CampusGaga',style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            
          ),),
        ),
      ),
      SizedBox(
        height:15.0
      ),
      Container(
          width:double.infinity,
          
          child: Column(
            children:
          <Widget>[
            Text('FROM',style:GoogleFonts.getFont('Quicksand'),),
                Text('CampusGaga',style:GoogleFonts.getFont('Dancing Script').copyWith(fontSize:24.0),)
          ],
          ),),
],


),

                  );
  }
}

