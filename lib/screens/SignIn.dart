import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:meditation_app/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:flutter_svg/svg.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();
  bool _saving = false;

  String userEmail;
  String userPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ModalProgressHUD(
          inAsyncCall: _saving,
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: Text('Hello',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                        child: Text('Smart',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                        child: Text(' .',
                            style: TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple)),
                      )
                    ],
                  ),
                ),
                Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
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
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                        ),
                        SizedBox(height: 20.0),
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
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                          obscureText: true,
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: InkWell(
                            onTap: () {
                              Toast.show("forgot password", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.CENTER);
                                  Navigator.pushNamed(context, '/forgetpassword');
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                       SizedBox(height:10.0),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              setState((){
                                _saving=true;
                              });
                              final user = await _authService.signIn(
                                  mEmail: userEmail, mPassword: userPassword);

                              if (user != null) {
                                 setState((){
                                _saving=false;
                              });
                                Navigator.pushReplacementNamed(context, '/home');
                              } else {
                                Navigator.pushNamed(
                                    context, '/signup');
                                DangerAlertBoxCenter(context: context,
                                messageText: 'You \'ve not registered with us.\nOr your email is not verified! '
                                );
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
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to Smart ?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      
                      onTap: () {
                        Toast.show("Register", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 18.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height:20.0
                ),
        Container(
          width:double.infinity,
          child: Column(
            children:
          <Widget>[
            Text('FROM',style:GoogleFonts.getFont('Quicksand'),),
                Text('CampusGaga',style:GoogleFonts.getFont('Dancing Script').copyWith(fontSize:18.0),)
          ],
          ),),
                //add from campus gaga text 
              ],
            ),
          ),
        ),);
  }
}
