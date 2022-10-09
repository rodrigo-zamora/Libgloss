import 'package:flutter/material.dart';

import '../../config/routes.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';
import '../../widgets/side_menu.dart';

class NewBookDetails extends StatefulWidget {
  NewBookDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<NewBookDetails> createState() => _NewBookDetailsState();
}

class _NewBookDetailsState extends State<NewBookDetails> {
  Color _primaryColor = Color.fromRGBO(199, 246, 255, 1);
  Color _secondaryColor = Color.fromRGBO(124, 196, 209, 1);

  TextEditingController _textFieldController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
            primaryColor: _primaryColor,
            secondaryColor: _secondaryColor,
            textFieldController: _textFieldController,
            showMenuButton: false,
            showCameraButton: false),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.HOME, iconColor: _secondaryColor),
    );
  }
}
