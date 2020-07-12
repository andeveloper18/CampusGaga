import 'package:flutter/material.dart';
import 'package:meditation_app/widgets/bottom_nav_bar.dart';
import 'package:meditation_app/services/DatabaseService.dart';
import 'package:flip_card/flip_card.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayScreen extends StatefulWidget {
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(whichScreen: 'today'),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                
                    
                Container(
                  margin: EdgeInsets.symmetric(vertical:10.0,horizontal:8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black.withOpacity(.55),
                    ),
                    width: double.infinity,
                    height: 50.0,
                    child: Center(
                      child: Text(
                        'Tips & Tricks',
                        
                        style: GoogleFonts.getFont('Roboto').copyWith(
                          color:Colors.white,
                        fontWeight:FontWeight.bold,
                        fontSize:28.0
                        ),
                      ),
                    )),
                  
                StreamBuilder(
                    stream: _databaseService.getTodayChallenge(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                        );
                      }
                      final todayCard = snapshot.data.documents;
                      List<TodayCard> todayCards = [];
                      for (var today in todayCard) {
                        final todayTitle = today.data['title'];
                        //final todayDate = today.data['day'];
                        final todayText = today.data['message'];
                        final todayNum = today.data['number'];
                        final todayCard = TodayCard(
                          mTitle: todayTitle,
                          mText: todayText,
                          mNum:todayNum,
                          // mDateTime:todayDate.toDate(),
                        );
                        // press: () {},

                        todayCards.add(todayCard);
                      }
                      return Column(
                        children: todayCards,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodayCard extends StatelessWidget {
  final String mTitle;
  final String mText;
  final int mNum;
//final DateTime mDateTime;

  TodayCard({
    this.mTitle,
    this.mText, //this.mDateTime
    this.mNum
  });
  @override
  Widget build(BuildContext context) {
    return   FlipCard(
  direction: FlipDirection.HORIZONTAL, // default
  front: Container(
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.all(2.0),
    height: 90,
    width: double.infinity,
   decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:BorderRadius.circular(16.0)
   ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
               
               
                Text('$mNum',style:GoogleFonts.getFont('Roboto').copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 24.0
                ),),
                Text('Tip',style:GoogleFonts.getFont('Roboto').copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 18.0
                ) ),
              ],
            ),
            VerticalDivider( thickness: 2,color: Colors.black,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
             
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                  Text('$mTitle',
                  overflow: TextOverflow.ellipsis
                  ,style:GoogleFonts.getFont('Roboto').copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 24.0,
                  color: Colors.grey
                ))

            ],)
          ],
        ),
    ),
    back: Container(
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.all(2.0),
    height: 90,
    width: double.infinity,
   decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:BorderRadius.circular(16.0)
   ),
        child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
             
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                  Text('$mText',style:GoogleFonts.getFont('Roboto').copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 24.0,
                  color: Colors.grey
                ))

            ],)
          
    ),
);
  }
}
