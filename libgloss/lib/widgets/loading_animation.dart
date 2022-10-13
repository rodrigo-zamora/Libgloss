import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  final Color _animationColor;

  LoadingAnimation({
    Key? key,
    required Color animationColor,
  })  : _animationColor = animationColor,
        super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      height: 140,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 30.0,
          fontFamily: 'Elegant',
          color: widget._animationColor,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              '\"For what do we live,', 
              speed: Duration(milliseconds: 32),
            ),
            TypewriterAnimatedText(
              'but to make sport for our neighbours,', 
              speed: Duration(milliseconds: 39),
            ),
            TypewriterAnimatedText(
              'and laugh at them in our turn?\"', 
              speed: Duration(milliseconds: 39),
            ),
            TypewriterAnimatedText(
              '- Pride and Prejudice by Jane Austen', 
              speed: Duration(milliseconds: 40),
            ),
          ],
          onTap: () {
            print("Tap Event");
          },
          repeatForever: true,
        ),
      ),
    );
  }
}