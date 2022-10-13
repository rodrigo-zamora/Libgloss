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
          fontFamily: 'Cats',
          color: widget._animationColor,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText('Discipline is the best tool'),
            TypewriterAnimatedText('Design first, then code'),
            TypewriterAnimatedText('Do not patch bugs out, rewrite them'),
            TypewriterAnimatedText('Do not test bugs out, design them out'),
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