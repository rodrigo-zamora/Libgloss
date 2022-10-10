import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import '../../../widgets/bottom_navigation.dart';
import '../../../widgets/search_appbar.dart';
import '../../model/user.dart';

class UserOptions extends StatelessWidget {
  final Color _primaryColor = Color.fromRGBO(248, 187, 176, 1);
  final Color _secondaryColor = Color.fromRGBO(245, 128, 107, 1);
  final Color _tertiaryColor = Color.fromRGBO(251, 236, 233, 1);
  final Color _iconColors = Color.fromRGBO(36, 36, 36, 1);

  final TextEditingController _textFieldController = TextEditingController();

  static const user = User (
    image: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    name: "Agnes Betancourt",
    email: "agnes.betancourt@gmail.com",
    isSeller: false,
  );

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
              user.name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: _iconColors,
              ),
            ),
            Text(
              user.email,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
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
          GestureDetector(
            onTap: () { print("HI"); },
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.image),
            ),
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
                  //Icons.photo_camera_outlined,
                  Icons.edit_outlined,
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
