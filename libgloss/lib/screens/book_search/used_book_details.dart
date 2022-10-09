import 'package:flutter/material.dart';

import '../../config/routes.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';
import '../../widgets/side_menu.dart';
class UsedBookDetails extends StatefulWidget {
  const UsedBookDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<UsedBookDetails> createState() => _UsedBookDetailsState();
}

class _UsedBookDetailsState extends State<UsedBookDetails> {
  final Color _primaryColor = Color.fromRGBO(211, 241, 173, 1);
  final Color _secondaryColor = Color.fromRGBO(118, 174, 46, 1);

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
      bottomNavigationBar: BottomNavigation(selectedItem: LibglossRoutes.HOME),
    );
  }
}
