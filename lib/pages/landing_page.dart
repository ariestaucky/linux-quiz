import 'package:flutter/material.dart';
import 'package:quizioning/ui/startButton.dart';
import './quiz_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  void start() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => QuizPage(),
        transitionsBuilder: (context, anim1, anim2, child) =>
            FadeTransition(opacity: anim1, child: child),
        transitionDuration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("linux.jpg"), fit: BoxFit.cover)),
            child: StartButton(start)));
  }
}
