import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';

class UsedBookSeller extends StatelessWidget {
  final Color _primaryColor = Color.fromRGBO(211, 241, 173, 1);
  final Color _secondaryColor = Color.fromRGBO(118, 174, 46, 1);
  
  final TextEditingController _textFieldController = TextEditingController();

  UsedBookSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          textFieldController: _textFieldController,
          showMenuButton: false,
          showCameraButton: false,
        ),
      ),
      body: Container(),
      bottomNavigationBar:
          BottomNavigation(selectedItem: LibglossRoutes.USED_BOOK_SELLER),
    );
  }
}
