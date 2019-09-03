import 'package:flutter/material.dart';

import '../ui/answer_button.dart';
import '../ui/question_text.dart';
import '../ui/correct_wrong_overlay.dart';

import './score_page.dart';
import '../utils/soal.dart';
import 'landing_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  void finish() {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
            builder: (BuildContext context) => new LandingPage()),
        (Route route) => route == null);
    setState(() {
      //   quiz.score = 0;
      //   // quiz.currentQuestionIndex = -1;
      quiz.reset();
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Container(
              child: new Text(
                "Quit",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            content: new Text(
              "Are you sure?",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  "No",
                ),
              ),
              new FlatButton(
                onPressed: finish,
                child: new Text(
                  "Yes",
                ),
              ),
            ],
          ),
    ) ??
    false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              children: <Widget>[
                Expanded(child: new QuestionText(questionText, questionNumber)),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      new AnswerButton(
                          true, () => handleAnswer(true)), //true button
                      new AnswerButton(
                          false, () => handleAnswer(false)), // false button
                    ],
                  ),
                ),
              ],
            ),
            overlayShouldBeVisible == true
                ? new CorrectWrongOverlay(isCorrect, () {
                    if (quiz.length == questionNumber) {
                      Navigator.of(context).pushAndRemoveUntil(
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new ScorePage(
                                  score: quiz.score,
                                  totalQuestions: quiz.length)),
                          (Route route) => route == null);
                      return;
                    }
                    // print([
                    //   // quiz.score,
                    //   // currentQuestion,
                    //   quiz.length,
                    //   questionNumber,
                    //   quiz.questions
                    //   // questionNumber,
                    //   // quiz.questionNumber
                    // ]);
                    currentQuestion = quiz.nextQuestion;
                    this.setState(() {
                      overlayShouldBeVisible = false;
                      questionText = currentQuestion.question;
                      questionNumber = quiz.questionNumber;
                    });
                  }, currentQuestion.fact)
                : new Container()
          ],
        ),
      ),
    );
  }
}
