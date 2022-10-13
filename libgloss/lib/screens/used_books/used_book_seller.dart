import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import '../../widgets/shared/bottom_navigation.dart';
import '../../widgets/shared/search_appbar.dart';

class UsedBookSeller extends StatefulWidget {
  UsedBookSeller({
    super.key,
  });

  @override
  State<UsedBookSeller> createState() => _UsedBookSellerState();
}

class _UsedBookSellerState extends State<UsedBookSeller> {
  final Color _primaryColor = Color.fromRGBO(211, 241, 173, 1);
  final Color _secondaryColor = Color.fromRGBO(118, 174, 46, 1);

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments;
    _args as Map<String, dynamic>;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: false,
          showCameraButton: false,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              _args["vendedor"] as String,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                //color: _secondaryColor,
              ),
            ),
            Text(
              _args["localizacion"] as String,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                //color: _secondaryColor,
              ),
            ),
            Text(
              _args["contacto"] as String,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                //color: _secondaryColor,
              ),
            ),
            SizedBox(height: 20),
            //_profilePicture(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.HOME_USED, iconColor: _secondaryColor),
    );
  }
}
