import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

import 'landing_page.dart';

class ScorePage extends StatefulWidget {
  final int score;
  final int totalQuestions;

  ScorePage({this.score, this.totalQuestions});

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

  void initState() {
    super.initState();
    sfx();
  }

  sfx() {
    if(widget.score <= 5) {
      music.play("lose.mp3");
    } else {
      music.play("victory.mp3");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.blueAccent,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Your Score: ",
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0),
            ),
            new Text(
                widget.score.toString() +
                    "/" +
                    widget.totalQuestions.toString(),
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0)),
            new Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              child: new FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text(
                      "BACK TO START",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                    ),
                    new IconButton(
                      icon: new Icon(Icons.arrow_right),
                      color: Colors.blueAccent,
                      iconSize: 50.0,
                      onPressed: null
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new LandingPage()),
                      (Route route) => route == null);
                },
              ),
            )
          ],
        ));
  }
}

AudioCache music =AudioCache();
