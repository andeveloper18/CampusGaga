import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:meditation_app/services/auth.dart';
import 'package:meditation_app/services/DatabaseService.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService();

  String userName;
  String userEmail;
  String userPassword;
  bool _saving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid email address!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            userEmail = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple))),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid password !';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            userPassword = value;
                          });
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple))),
                        obscureText: true,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            userName = value;
                          });
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple))),
                      ),
                      SizedBox(height: 50.0),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _saving = true;
                            });
                            bool savedName= await _databaseService.setUserName(userName);
                            final user = await _authService.signUp(
                                mEmail: userEmail,
                                mPassword: userPassword,
                                mUserName: userName);

                            if (user != null) {
                              setState(() {
                                _saving = false;
                              });
                              Navigator.pushReplacementNamed(
                                  context, '/introduction');
                              // InfoBgAlertBox(context: context,
                              // title: 'Verification',
                              // titleTextColor: Colors.white,
                              // buttonText: 'Done',
                              // buttonTextColor: Colors.black,
                              // buttonColor: Colors.purple,
                              // messageTextColor: Colors.white,
                              // infoMessage: 'Verification email has been sent to your registered email.\nCheck your email inbox.'
                              // );
                              SuccessAlertBox(
                                  context: context,
                                  title: 'Verification',
                                  messageTextColor: Colors.black,
                                  buttonText: 'Done',
                                  buttonTextColor: Colors.black,
                                  buttonColor: Colors.purple,
                                  messageText:
                                      'Verification email has been sent to your registered email.\nCheck your email inbox.');
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, '/signup');
                            }
                          } else {
                            return null;
                          }
                        },
                        child: Container(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.purpleAccent,
                              color: Colors.purple,
                              elevation: 7.0,
                              child: Center(
                                child: Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signin');
                            },
                            child: Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Container(
          width:double.infinity,
          child: Column(
            children:
          <Widget>[
            Text('FROM',style:GoogleFonts.getFont('Quicksand'),),
                Text('CampusGaga',style:GoogleFonts.getFont('Dancing Script').copyWith(fontSize:18.0),)
          ],
          ),),
            ],
          ),
        ),
      ),
    );
  }
}
