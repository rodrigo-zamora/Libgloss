import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libgloss/config/routes.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';

class BookTracker extends StatelessWidget {
  final Color _appBarColor = Color.fromRGBO(199, 246, 255, 1);
  final TextEditingController _textFieldController = TextEditingController();

  BookTracker({super.key});

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
          textFieldController: _textFieldController,
          showMenuButton: true,
          showCameraButton: false,
        ),
      ),
      body: Container(),
      bottomNavigationBar:
          BottomNavigation(selectedItem: LibglossRoutes.BOOK_TRACKER),
    );
  }
}
