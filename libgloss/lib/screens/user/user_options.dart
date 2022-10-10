import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import '../../../widgets/bottom_navigation.dart';
import '../../../widgets/search_appbar.dart';

class UserOptions extends StatelessWidget {
  final Color _primaryColor = Color.fromRGBO(248, 187, 176, 1);
  final Color _secondaryColor = Color.fromRGBO(245, 128, 107, 1);
  final Color _tertiaryColor = Color.fromRGBO(251, 236, 233, 1);
  final Color _iconColors = Color.fromRGBO(36, 36, 36, 1);

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Agnes Betancourt",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: _iconColors,
              ),
            ),
            SizedBox(height: 20),
            _profilePicture(),
            SizedBox(height: 20),
            _button(
              Icons.person_outlined, 
              "Mi Cuenta", 
              () {}
            ),
            _button(
              Icons.notifications_outlined, 
              "Notificaciones y mensajes", 
              () {}
            ),
            _button(
              Icons.help_outline, 
              "Configuración", 
              () {}
            ),
            _button(
              Icons.logout_outlined, 
              "Salir", 
              () {}
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.OPTIONS, iconColor: _secondaryColor),
    );
  }

  SizedBox _profilePicture() {
    return SizedBox(
      height: 110,
      width: 110,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/temporary_user.jpeg"),
          ),
          Positioned(
            bottom: 0,
            right: -10,
            child: SizedBox(
              height: 40,
              width: 40,
              child: FloatingActionButton(
                backgroundColor: _primaryColor,
                splashColor: _secondaryColor, 
                onPressed: () {},
                child: Icon(
                  Icons.photo_camera_outlined,
                  color: _iconColors,
                  size: 22,
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  Padding _button(IconData icon, String text, Function() onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_tertiaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(10),
          ),
          overlayColor: MaterialStateColor.resolveWith((states) => _primaryColor),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: _secondaryColor,
              size: 22,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: _iconColors,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: _secondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
