import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import "dart:math";

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
          color: widget()._animationColor,
        ),
        child: _buildAnimatedText(),
      ),
    );
  }

  Widget _buildAnimatedText() {
    switch (Random().nextInt(5)) {
      case 0:
        return _pride();
      case 1:
        return _little();
      case 2:
        return _hate();
      case 3:
        return _love();
      case 4:
        return _pass();
      default:
        return _pride();
    }
  }

  AnimatedTextKit _pride() {
    return AnimatedTextKit(
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
      repeatForever: true,
    );
  }

  AnimatedTextKit _little() {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          '\"I am not afraid of storms,', 
          speed: Duration(milliseconds: 57),
        ),
        TypewriterAnimatedText(
          'for I am learning how to sail my ship.\"', 
          speed: Duration(milliseconds: 57),
        ),
        TypewriterAnimatedText(
          '- Little Women by Louisa May Alcott', 
          speed: Duration(milliseconds: 57),
        ),
      ],
      repeatForever: true,
    );
  }

  AnimatedTextKit _hate() {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          '\"What\'s the point of having a voice if', 
          speed: Duration(milliseconds: 42),
        ),
        TypewriterAnimatedText(
          'you\'re gonna be silent in those moments', 
          speed: Duration(milliseconds: 42),
        ),
        TypewriterAnimatedText(
          'you shouldn\'t be?\"', 
          speed: Duration(milliseconds: 30),
        ),
        TypewriterAnimatedText(
          '- The Hate U Give by Angie Thomas', 
          speed: Duration(milliseconds: 37),
        ),
      ],
      repeatForever: true,
    );
  }

  AnimatedTextKit _love() {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          '\"They say nothing lasts forever', 
          speed: Duration(milliseconds: 38),
        ),
        TypewriterAnimatedText(
          'but they\'re just scared it will last', 
          speed: Duration(milliseconds: 38),
        ),
        TypewriterAnimatedText(
          'longer than they can love it.\"', 
          speed: Duration(milliseconds: 28),
        ),
        TypewriterAnimatedText(
          '- On Earth We\'re Briefly Gorgeous by Ocean Vuong', 
          speed: Duration(milliseconds: 50),
        ),
      ],
      repeatForever: true,
    );
  }

  AnimatedTextKit _pass(){
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          '\"Beware; for I am fearless,', 
          speed: Duration(milliseconds: 68),
        ),
        TypewriterAnimatedText(
          'and therefore powerful.\"', 
          speed: Duration(milliseconds: 68),
        ),
        TypewriterAnimatedText(
          '- Frankenstein by Mary Shelley', 
          speed: Duration(milliseconds: 68),
        ),
      ],
      repeatForever: true,
    );
  }
}