import 'package:flutter/material.dart';

import 'package:meditation_app/screens/details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditation_app/widgets/bottom_nav_bar.dart';
import 'package:meditation_app/widgets/category_card.dart';
import 'package:meditation_app/services/DatabaseService.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
         DatabaseService _databaseService=DatabaseService();
String userName ='smart';

 

   void getNameLocal() async{
   String userLocalName= await _databaseService.getUserNameLocal();
       setState(() {
     userName = userLocalName;
    });
    }

@override
  void initState() {
    getNameLocal();
    super.initState();
  }
    


  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
        bottomNavigationBar: BottomNavBar(whichScreen: 'home'),
      

    
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: double.infinity,
                  height: 250.0,
                  decoration: BoxDecoration(
                      image:DecorationImage(image:AssetImage('assets/images/hello.png') ,fit:BoxFit.cover ),
                    borderRadius: BorderRadius.only(bottomLeft:Radius.circular(36.0),bottomRight:Radius.circular(36.0)),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello!',
                        
                        style: GoogleFonts.getFont('Patrick Hand').copyWith(
                         fontWeight: FontWeight.w900,
                            fontSize: 42.0,
                            color: Colors.purple
                          
                        ),
                        
                        ),
                      Text(
                        userName,

                        textAlign: TextAlign.start,
                        style: GoogleFonts.getFont('Cookie').copyWith(
                          fontSize:52.0,
                          color:Colors.black
                        ),
                        
                      ),
                      Divider(
                        height: 5.0,
                        indent: 2,
                        thickness: 2,
                        color: Colors.white
                      )
                    ],
                  ),
                ),

                // Text(
                //   "Good Morning \nShivam !",
                //   style: Theme.of(context)
                //       .textTheme
                //       .headline4
                //       .copyWith(
                //         color:Colors.purple,
                //         fontWeight: FontWeight.w900),
                // ),
                //  SearchBar(),

                Text(
                  "Basic ",
                  style: GoogleFonts.getFont('Bungee Shade').copyWith(
                    fontSize:24.0,
                    color:Colors.black
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      CategoryCard(
                        title: "Arithmetic",
                        svgSrc: "assets/icons/Hamburger.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Arithmetic',
                              );
                            }),
                          );
                        },
                      ),
                      CategoryCard(
                        title: "Verbal Section",
                        svgSrc: "assets/icons/Excrecises.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Verbal',
                              );
                            }),
                          );
                        },
                      ),
                      CategoryCard(
                        title: "Non-Verbal",
                        svgSrc: "assets/icons/Meditation.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Non-Verbal',
                              );
                            }),
                          );
                        },
                      ),
                      CategoryCard(
                        title: "Logical Section",
                        svgSrc: "assets/icons/yoga.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Logical',
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Text(
                  "Featured Cards ",
                  style:GoogleFonts.getFont('Bungee Shade').copyWith(
                    fontSize:24.0,
                    color:Colors.black
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      CategoryCard(
                        title: "Arithmetic",
                        svgSrc: "assets/icons/Hamburger.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Arithmetic',
                              );
                            }),
                          );
                        },
                      ),
                      CategoryCard(
                        title: "Verbal Section",
                        svgSrc: "assets/icons/Excrecises.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Verbal',
                              );
                            }),
                          );
                        },
                      ),
                      CategoryCard(
                        title: "Non-Verbal",
                        svgSrc: "assets/icons/Meditation.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Non-Verbal',
                              );
                            }),
                          );
                        },
                      ),
                      CategoryCard(
                        title: "Logical Section",
                        svgSrc: "assets/icons/yoga.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Logical',
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Text(
                  "Advance  ",
                  style: GoogleFonts.getFont('Bungee Shade').copyWith(
                    fontSize:24.0,
                    color:Colors.black
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      CategoryCard(
                        title: "Arithmetic",
                        svgSrc: "assets/icons/Hamburger.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Arithmetic',
                              );
                            }),
                          );
                        },
                      ),
                      CategoryCard(
                        title: "Verbal Section",
                        svgSrc: "assets/icons/Excrecises.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Verbal',
                              );
                            }),
                          );
                        },
                      ),
                      CategoryCard(
                        title: "Non-Verbal",
                        svgSrc: "assets/icons/Meditation.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Non-Verbal',
                              );
                            }),
                          );
                        },
                      ),
                      CategoryCard(
                        title: "Logical Section",
                        svgSrc: "assets/icons/yoga.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailsScreen(
                                mSubjectName: 'Logical',
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
