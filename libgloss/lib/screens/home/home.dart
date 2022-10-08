import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _MainPageState();
}

class _MainPageState extends State<Home> {
  Color _appBarColor = Color.fromRGBO(199, 246, 255, 1);
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: _appBarColor,
    ));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
            appBarColor: _appBarColor,
            textFieldController: _textFieldController),
      ),
      body: Container(),
      bottomNavigationBar:
          BottomNavigation(selectedItem: BottomNavigation.HOME),
    );
  }
}
