import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import '../../../widgets/bottom_navigation.dart';
import '../../../widgets/search_appbar.dart';

class UserOptions extends StatelessWidget {
  final Color _primaryColor = Color.fromRGBO(248, 187, 176, 1);
  final Color _secondaryColor = Color.fromRGBO(245, 128, 107, 1);
  
  final TextEditingController _textFieldController = TextEditingController();

  UserOptions({super.key});

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
          selectedItem: LibglossRoutes.OPTIONS, iconColor: _secondaryColor),
    );
  }
}
