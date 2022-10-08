import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
    required Color appBarColor,
    required TextEditingController textFieldController,
    required bool showMenuButton,
    required bool showCameraButton,
  })  : _appBarColor = appBarColor,
        _textFieldController = textFieldController,
        _showMenuButton = showMenuButton,
        _showCameraButton = showCameraButton,
        super(key: key);

  final Color _appBarColor;
  final TextEditingController _textFieldController;
  final bool _showMenuButton;
  final bool _showCameraButton;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode)
      print("[SearchAppBar] Building SearchAppBar with color $_appBarColor");
    return AppBar(
      backgroundColor: _appBarColor,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                if (_showMenuButton)
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                if (!_showMenuButton)
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 325,
                      height: 30,
                      child: TextField(
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical(y: 1),
                        controller: _textFieldController,
                        decoration: InputDecoration(
                          hintText: "Buscar en Libgloss",
                          suffixIcon:
                              _showCameraButton ? Icon(Icons.camera_alt) : null,
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 32,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.topLeft,
                      color: Color.fromRGBO(124, 196, 209, 1),
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Image.asset(
                          'assets/onlybunny.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
