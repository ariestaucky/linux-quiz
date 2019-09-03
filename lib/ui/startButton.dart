import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class StartButton extends StatelessWidget {
  final VoidCallback callback;
  StartButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: callback,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Let's Start!",
              style: new TextStyle(
                  color: Colors.yellow,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
            ),
            ControlledAnimation(
              duration: Duration(milliseconds: 400),
              tween: Tween(begin: 0.0, end: 80.0),
              builder: (context, height) {
                return ControlledAnimation(
                  duration: Duration(milliseconds: 1200),
                  delay: Duration(milliseconds: 500),
                  tween: Tween(begin: 2.0, end: 300.0),
                  builder: (context, width) {
                    return Container(
                      width: width,
                      height: 60,
                      child: isEnoughRoomForTypewriter(width)
                          ? TypewriterText("Tap to start!", callback)
                          : Container(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  isEnoughRoomForTypewriter(width) => width > 20;
}

class TypewriterText extends StatelessWidget {
  static const TEXT_STYLE = TextStyle(
      letterSpacing: 5,
      fontSize: 24,
      fontWeight: FontWeight.w300,
      color: Colors.black);

  final VoidCallback callback;
  final String text;
  TypewriterText(this.text, this.callback);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
        duration: Duration(milliseconds: 800),
        delay: Duration(milliseconds: 800),
        tween: IntTween(begin: 0, end: text.length),
        builder: (context, textLength) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ControlledAnimation(
                playback: Playback.LOOP,
                duration: Duration(milliseconds: 600),
                tween: IntTween(begin: 0, end: 1),
                builder: (context, oneOrZero) {
                  return Opacity(
                      opacity: oneOrZero == 1 ? 1.0 : 0.0,
                      child: Text(text.substring(0, textLength),
                          style: TEXT_STYLE));
                },
              ),
              // ControlledAnimation(
              //   playback: Playback.LOOP,
              //   duration: Duration(milliseconds: 600),
              //   tween: IntTween(begin: 0, end: 1),
              //   builder: (context, oneOrZero) {
              //     return Opacity(
              //         opacity: oneOrZero == 1 ? 1.0 : 0.0,
              //         child: Text("_", style: TEXT_STYLE));
              //   },
              // )
            ],
          );
        });
  }
}
