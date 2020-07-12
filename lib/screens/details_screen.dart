
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/constants.dart';
import 'package:meditation_app/screens/SessionScreen.dart';
import 'package:meditation_app/services/DatabaseService.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:meditation_app/widgets/search_bar.dart';

class DetailsScreen extends StatefulWidget {

final String mSubjectName;
DetailsScreen({this.mSubjectName});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DatabaseService databaseService = DatabaseService();
  
InterstitialAd myInterstitial;

  InterstitialAd buildInterstitialAd() {
    return InterstitialAd(
      adUnitId: 'ca-app-pub-4915212972544535/1858847431',
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          myInterstitial..load();
        } else if (event == MobileAdEvent.closed) {
          myInterstitial = buildInterstitialAd()..load();
        }
        print(event);
      },
    );
  }

  void showInterstitialAd() {
    myInterstitial..show();
  }

  void showRandomInterstitialAd() {
    Random r = new Random();
    bool value = r.nextBool();

    if (value == true) {
      myInterstitial..show();
    }
  }

  @override
  void initState() {
    super.initState();

    myInterstitial = buildInterstitialAd()..load();
    showInterstitialAd();
  }

  @override
  void dispose() {
    myInterstitial.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      //bottomNavigationBar: BottomNavBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //floatingActionButton: FloatingActionButton.extended(onPressed: null, label:Icon(Icons.lock_open) ),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "${widget.mSubjectName}",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "30-40 minutes Course",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: Text(
                        "All the best for the sessions.",
                      ),
                    ),
                    SizedBox(
                      width: size.width * .5, // it just take the 50% width
                      child: SearchBar(),
                    ),
                    //card topics here
                    Container(
                      color: Colors.transparent,
                      height: size.height * .35, 
                      child: SingleChildScrollView(
                        child: StreamBuilder(
                            stream: databaseService.getTopicsBySubjectName(widget.mSubjectName),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                );
                              }
                              final mTopics = snapshot.data.documents;
                              List<SeassionCard> topicsCard = [];
                              for (var topic in mTopics) {
                                final topicTitle = topic.data['topicTitle'];

                                final topicCard = SeassionCard(
                                    // seassionNum: 6,
                                    isDone: false,
                                mSubjectNameofTopic: widget.mSubjectName,
                                    mTopic: topicTitle);
                                // press: () {},

                                topicsCard.add(topicCard);
                              }
                              return Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: topicsCard);
                            }),
                      ),
                    ),
                       

                    SizedBox(height: 20),
                    Text(
                      "Video Lectures ",
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0
                      ),
                    ),
                    ChapterCard(
                        mChapterName: 'Chapter 1',
                        mSubstitile: 'Start off your practice today! (COMING SOON)',
                        isLocked: true,
                    ),

                    ChapterCard(
                      mChapterName: 'Chapter 2',
                      mSubstitile: 'Coming soon!',
                      isLocked: true,
                    ),
                    ChapterCard(
                      mChapterName: 'Chapter 3',
                      mSubstitile: 'Coming soon!',
                      isLocked: true,
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChapterCard extends StatelessWidget {
  final String mChapterName;
  final String mSubstitile;
  final bool isLocked;
  final Function press;
  const ChapterCard(
      {Key key,
      this.mChapterName,
      this.mSubstitile,
      this.isLocked = true,
      this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(10),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
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
          onTap: press,
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/Meditation_women_small.svg",
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "$mChapterName",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    Text("$mSubstitile")
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: isLocked
                    ? SvgPicture.asset("assets/icons/Lock.svg")
                    : Icon(Icons.lock_open),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeassionCard extends StatelessWidget {
  // final int seassionNum;
  final bool isDone;
  final String mTopic;
  final String mSubjectNameofTopic;
  //final Function press;
  const SeassionCard(
      {Key key,
      //this.seassionNum,
      this.isDone = false,
     // this.press,
     this.mSubjectNameofTopic,
      this.mTopic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
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
              onTap:
               () { Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return SessionScreen(mSubjectName: mSubjectNameofTopic ,mTopicName: mTopic);//add subject name and topic name
                              }),
                            );},
              
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: isDone ? Colors.white : kBlueColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text( mTopic ?? 'Topic 1'
                          , //"Session $seassionNum",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Text(
                           'Topic 1',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                fontSize: 12,
                              ),
                        ),
                        //
                        //===========i have to add for full topic name
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

// Wrap(
//                     spacing: 20,
//                     runSpacing: 20,
//                     children: <Widget>[
//                       SeassionCard(
//                         seassionNum: 1,
//                         isDone: true,
//                         press: () {
//                           Navigator.pushNamed(context,'/sessionScreen');
//                         },
//                       ),
//                       SeassionCard(
//                         seassionNum: 2,
//                         press: () {
//                           databaseService.getQuestions();
//                         },
//                       ),
//                       SeassionCard(
//                         seassionNum: 3,
//                         press: () {},
//                       ),
//                       SeassionCard(
//                         seassionNum: 4,
//                         press: () {},
//                       ),
//                       SeassionCard(
//                         seassionNum: 5,
//                         press: () {},
//                       ),
//                       SeassionCard(
//                         seassionNum: 6,
//                         isDone: true,
//                         press: () {},
//                       ),
//                     ],
//                   ),
