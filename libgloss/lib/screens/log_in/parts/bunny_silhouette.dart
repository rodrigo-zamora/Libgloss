import 'package:flutter/material.dart';

class BunnySilhouette extends StatelessWidget {
  const BunnySilhouette({
    Key? key,
    required this.context,
    required AssetImage logo,
  }) : _logo = logo, super(key: key);

  final BuildContext context;
  final AssetImage _logo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.height * 0.15,
          alignment: Alignment.center,
          child: Image(
            image: _logo,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.height * 0.15,
          alignment: Alignment.center,
          child: Image(
            image: AssetImage('assets/images/silhouette.png'),
            color: Colors.grey[50],
          ),
        ),
      ]
    );
  }
}