import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';
import 'package:shimmer/shimmer.dart';
import '../../../widgets/bottom_navigation.dart';
import '../../../widgets/search_appbar.dart';
import '../../model/user.dart';

class UserOptions extends StatefulWidget {
  UserOptions({super.key});

  @override
  State<UserOptions> createState() => _UserOptionsState();
}

class _UserOptionsState extends State<UserOptions> {
  final Color _primaryColor = Color.fromRGBO(248, 187, 176, 1);
  final Color _secondaryColor = Color.fromRGBO(245, 128, 107, 1);
  final Color _tertiaryColor = Color.fromRGBO(251, 236, 233, 1);
  final Color _iconColors = Color.fromRGBO(36, 36, 36, 1);

  final TextEditingController _textFieldController = TextEditingController();

  var user = User(
    image:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    name: "Agnes Betancourt",
    email: "agnes.betancourt@gmail.com",
    isSeller: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            _sellerButton(),
            _followers(user.isSeller),
            SizedBox(height: 10),
            _lowButton(Icons.person_outlined, "Mi Cuenta", () {}),
            _lowButton(Icons.notifications_outlined,
                "Notificaciones y mensajes", () {}),
            _lowButton(Icons.help_outline, "Configuración", () {}),
            _lowButton(Icons.logout_outlined, "Salir", () {}),
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
            CachedNetworkImage(
              placeholder: (context, url) {
                return ClipOval(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100,
                      color: Colors.grey[300],
                    ),
                  ),
                );
              },
              fit: BoxFit.contain,
              imageUrl: user.image,
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  backgroundImage: imageProvider,
                );
              },
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
                  onPressed: () {
                    _show();
                  },
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
        ));
  }

  Padding _lowButton(IconData icon, String text, Function() onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
          overlayColor:
              MaterialStateColor.resolveWith((states) => _primaryColor),
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

  Padding _sellerButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 90),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(10),
          ),
          overlayColor:
              MaterialStateColor.resolveWith((states) => _tertiaryColor),
        ),
        onPressed: () {
          user.isSeller = !user.isSeller;
          setState(() {});
        },
        child: Row(
          children: [
            Expanded(
              child: _text(user.isSeller),
            ),
          ],
        ),
      ),
    );
  }

  Text _text(bool isSeller) {
    if (!isSeller) {
      return Text(
        "Convertirse en Vendedor",
        style: TextStyle(
          color: _iconColors,
        ),
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        "Ya eres Vendedor",
        style: TextStyle(
          color: _iconColors,
        ),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _followers(bool isSeller) {
    if (isSeller) {
      return IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(4.8, 'Ranking'),
            VerticalDivider(
              color: _secondaryColor,
              thickness: 0.5,
            ),
            _buildButton(90, 'Seguidores'),
            VerticalDivider(
              color: _secondaryColor,
              thickness: 0.5,
            ),
            _buildButton(30, 'Seguidos'),
          ],
        ),
      );
    } else {
      return IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(4.9, 'Ranking'),
            VerticalDivider(
              color: _secondaryColor,
              thickness: 0.5,
            ),
            SizedBox(
              width: 88,
              child: Text(
                "¡Convierteté en vendedor!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: _iconColors,
                ),
              ),
            ),
            VerticalDivider(
              color: _secondaryColor,
              thickness: 0.5,
            ),
            _buildButton(45, 'Seguidos'),
          ],
        ),
      );
    }
  }

  Widget _buildButton(double number, String text) {
    var numberDisplay;
    if (number % 1 == 0)
      numberDisplay = number.toInt().toString();
    else
      numberDisplay = number.toString();
    return MaterialButton(
      padding: EdgeInsets.all(5),
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        children: [
          Text(
            numberDisplay,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _iconColors,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: _iconColors,
            ),
          ),
        ],
      ),
    );
  }

  Widget _show() {
    return AlertDialog(
      title: Text('AlertDialog Title'),
      content: Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
