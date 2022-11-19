import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final _primaryColor;
  final _secondaryColor;
  final _tertiaryColor;

  Filter({
    Key? key,
    required Color primary,
    required Color secondary,
    required Color tertiary,
  })  : _primaryColor = primary,
        _secondaryColor = secondary,
        _tertiaryColor = tertiary,
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
            MaterialStateColor.resolveWith((states) => _secondaryColor),
      ),
      onPressed: () {
        // TODO: implement filter
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Filtros",
              style: TextStyle(
                color: _tertiaryColor,
              ),
            ),
          ),
          Icon(
            Icons.expand_more,
            color: _tertiaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
