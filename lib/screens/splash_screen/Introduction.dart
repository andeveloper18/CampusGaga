import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';



  class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => _SplashScreenState();
  }
  
  class _SplashScreenState extends State<SplashScreen> {

     final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushReplacementNamed(context,'/signin');

  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }
  
    @override
    Widget build(BuildContext context) {
       const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Learn and Practice Anywhere, Anytime",
          body:
              "You can practice anywhere and anytime in just few clicks.",
          image: _buildImage('img1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Artificial intelligence processed",
          body:
              "Our app use AI techniques to help you in practice.",
          image: _buildImage('img2'), 
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Chill, Relax and Practice more! ",
          body:
              "On the go video lectures on concepts and you can learn more easy with more quality content.",
          image: _buildImage('img3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          
          title: "My Stopwatch",
          body: "Another beautiful and powerful feature to track your speed for each question.",
          image: _buildImage('img5'),
        
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Enter into the world of questions",
          body: "Hundred of unique questions collection.",
          image: _buildImage('img4'),
          decoration: pageDecoration,
        ),
         PageViewModel(
          title: "App made with Love",
          body: "Our team did all the hardwork for you...\nso you can practice well and do well in you exam.\nLets crack it!",
          image: _buildImage('img6'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.purple,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
    }
  }