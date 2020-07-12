import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meditation_app/constants.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class QuestionCard extends StatefulWidget {
  final String mQuestion;
  final int mQuestionNumber;
  final String mAnswer;
  final List<String> mOption;
  final bool isDone;
  final Function press;
  QuestionCard(
      {Key key,
      this.mQuestionNumber,
      this.mQuestion,
      this.mAnswer,
      this.isDone = true,
      this.mOption,
      this.press});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        // width: size.width * 50 ,
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        offset: Offset(0, 17),
        blurRadius: 23,
        spreadRadius: -13,
        color: kShadowColor,
      ),
    ],
        ),
        child: Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: widget.press,
      child: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text.rich(
              TextSpan(
                text: 'Q1.',
                style: TextStyle(
                    fontWeight: FontWeight.bold), // default text style
                children: <TextSpan>[
                  TextSpan(
                    text: '${widget.mQuestion} ?',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    text: '#Note : ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold), // default text style
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Here is some tips/hints.',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    
         Column(children: <Widget>[   RadioButtonGroup(
                labels: widget.mOption,
                onSelected: (String selected) => print(selected)),
            SizedBox(height: 10.0),
           
             ExpansionTile(
               
                  title: Text('Answer',
                  textAlign: TextAlign.start,
                  style: TextStyle(

                    fontWeight:FontWeight.bold
                  ),),
                  //trailing: Text('hjfdcghcgchgfvjhvjh,vj,h'),
                 // leading: Text('gfhjghjgbhjbghjbgjhghjvhj'),
                 children: <Widget>[ 
                   Container(
                     padding: EdgeInsets.symmetric(horizontal:10.0),
                     width: double.infinity,
                     child: Text(widget.mAnswer,
                     textAlign: TextAlign.start,
                     style: TextStyle(fontWeight: FontWeight.bold),),
                   )
                 ]
                ), ],),  
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    ),
        ),
      );
  }
}
