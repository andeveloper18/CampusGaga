import 'package:flutter/material.dart';
import 'package:meditation_app/constants.dart';
import 'package:meditation_app/screens/details_screen.dart';
import 'package:meditation_app/screens/settings.dart';
import 'package:meditation_app/screens/today_screen.dart';
import 'package:meditation_app/screens/HomeScreen.dart';
import 'package:meditation_app/screens/SessionScreen.dart';
import 'package:meditation_app/screens/SignIn.dart';
import 'package:meditation_app/screens/SignUp.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/screens/splash_screen/Introduction.dart';
import 'package:meditation_app/screens/forgotPassword.dart';
import 'package:meditation_app/services/PushNotificationService.dart';
import 'package:meditation_app/services/DatabaseService.dart';
bool isLoggedIn = false;
void main() {
  
    
    
      runApp(new MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
} 

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
DatabaseService _databaseService =DatabaseService();




  @override
  void initState() {
    checkUserLoginStatus();
  PushNotificationsManager _pushNotification = PushNotificationsManager();
    _pushNotification.init();
    super.initState();
  }


  void checkUserLoginStatus()async{
   await _databaseService.userLogStatus().then((value) {
  setState(() {
    isLoggedIn = value;
  });
   }) ;

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'CampusGaga',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      initialRoute:(isLoggedIn?? false)?'/home':'/signin',
      routes: {
       
        '/detailedScreen':(context)=>DetailsScreen(),
      
         '/home':(context)=>HomeScreen(),
        '/settings':(context)=>SettingScreen(),
        '/sessionScreen':(context)=>SessionScreen(),
         '/signin':(context)=>SignIn(),
          '/signup':(context)=>SignUp(),
       '/introduction':(context)=>SplashScreen(),
        '/forgetpassword':(context)=>ForgetPassword(),
        '/today':(context)=>TodayScreen() // '/class':(context)=>YoutubeClass(),
      },
    );
  }
}
