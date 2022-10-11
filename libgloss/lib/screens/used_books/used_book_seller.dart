import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import '../../../widgets/bottom_navigation.dart';
import '../../../widgets/search_appbar.dart';

class UsedBookSeller extends StatefulWidget {
  String? vendedor; 
  String? localizacion;
  String? contacto;

  UsedBookSeller({
    super.key,
    required this.vendedor,
    required this.localizacion,
    required this.contacto,
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              widget.vendedor as String,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                //color: _secondaryColor,
              ),
            ),
            Text(
              widget.localizacion as String,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                //color: _secondaryColor,
              ),
            ),
            Text(
              widget.contacto as String,
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
          selectedItem: LibglossRoutes.HOME_USED,
          iconColor: _secondaryColor),
    );
  }
}
