import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final _primaryColor;
  final _secondaryColor;

  Filter({
    Key? key,
    required Color primary,
    required Color secondary,
  })  : _primaryColor = primary,
        _secondaryColor = secondary,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(_primaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        overlayColor:
            MaterialStateColor.resolveWith((states) => _primaryColor),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Filter",
              style: TextStyle(
                color: _secondaryColor,
              ),
            ),
          ),
          Icon(
            Icons.expand_more,
            color: _secondaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}