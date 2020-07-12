import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/widgets/QuestionCard.dart';
import 'package:meditation_app/constants.dart';
import 'package:meditation_app/services/DatabaseService.dart';
import 'package:meditation_app/widgets/MyStopwatch.dart';
//import 'package:meditation_app/widgets/bottom_nav_bar.dart';
//import 'package:meditation_app/widgets/search_bar.dart';


PageController _pageController = PageController(keepPage: true);
DatabaseService databaseService = DatabaseService();

class SessionScreen extends StatefulWidget {

final String mSubjectName;
final String mTopicName;
SessionScreen({this.mSubjectName,this.mTopicName});

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    widget.mTopicName,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "20-35 MIN (APPROX)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: size.width * .6, // it just take 60% of total width
                    child: Text(
                      'Instructions',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cario-SemiBold'),
                    ),
                  ),
                  SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('1.All questions are from the mentioned topic'),
                      Text('2.Swipe up to see answer.'),
                      Text('3.Swipe right to change question.'),
                      Text('4.You can use stopwatch to track speed.'),
                    ],
                  )),
               
                 
                  //============here to add question card=================
                  Container(
                    color: Colors.transparent,

                    height: MediaQuery.of(context).size.height * 0.5,
                    child: StreamBuilder(
        stream: databaseService.getQuestionsBySubjectNameAndTopicName(widget.mSubjectName, widget.mTopicName),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final questions = snapshot.data.documents;
          List<QuestionCard> questionTiles = [];
          for (var question in questions) {
            final questionText = question.data['question'];
              final questionAnswer = question.data['answer'];
            List<String> listOfOptions=[];
            
             for(int i =0;i<question.data['option'].length;i++){
               String option = question.data['option'][i];
               listOfOptions.add(option);

             }

       
             
              // final questionOption1 = question.data['option1'];
              // final questionOption2 = question.data['option2'];

            final questionCard = QuestionCard(
              mQuestion: questionText,
               mAnswer:questionAnswer ,
               mOption: listOfOptions,
            );

            questionTiles.add(questionCard);
          }
          return PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: questionTiles,
            );
        })
                  ),

            MyStopwatch(),
            SizedBox(height: 15.0,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


