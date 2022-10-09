import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';

class BookTracker extends StatelessWidget {
  final Color _primaryColor = Color.fromRGBO(244, 210, 255, 1);
  final Color _secondaryColor = Color.fromRGBO(192, 85, 229, 1);
  final TextEditingController _textFieldController = TextEditingController();

  BookTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          textFieldController: _textFieldController,
          showMenuButton: true,
          showCameraButton: false,
        ),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.BOOK_TRACKER,
          iconColor: _secondaryColor),
    );
  }
}
