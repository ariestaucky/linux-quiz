import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber);

  @override
  State createState() => new QuestionTextState();
}

class QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    super.initState();
    _fontSizeAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);
    _fontSizeAnimation = new CurvedAnimation(
        parent: _fontSizeAnimationController, curve: Curves.bounceOut);
    _fontSizeAnimation.addListener(() => this.setState(() {}));
    _fontSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Padding(
          padding: new EdgeInsets.symmetric(vertical: 40.0),
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Wrap(
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: <Widget>[
                new Text(
                  "Statement " + widget._questionNumber.toString() + ": ",
                  style: new TextStyle(fontSize: _fontSizeAnimation.value * 16),
                ),
                new Padding(
                  padding: new EdgeInsets.only(bottom: 16.0),
                ),
                new Text(
                  widget._question,
                  style: new TextStyle(fontSize: _fontSizeAnimation.value * 18),
                )
              ],
            ),
          )),
    );
  }
}
