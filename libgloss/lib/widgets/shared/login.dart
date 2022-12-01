import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import 'search_appbar.dart';

class LogInForm extends StatefulWidget {
  LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.CURRENT_ROUTE);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.CURRENT_ROUTE);
  final Color _tertiaryColor =
      ColorSelector.getTertiary(LibglossRoutes.CURRENT_ROUTE);
  final Color _iconColors = ColorSelector.getGrey();
  final AssetImage _logo =
      ColorSelector.getBackground(LibglossRoutes.CURRENT_ROUTE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: true,
          showCameraButton: false,
          showSearchField: true,
        ),
      ),
      body: _inside(),
    );
  }

  Container _inside() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          _bunny(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          _logText(
            Icons.person_outlined,
            "Ingresa tu e-mail",
            (value) {},
            null,
            false,
          ),
          _logText(
            Icons.lock_outline,
            "Ingresa tu password",
            (value) {},
            Icons.visibility,
            true,
          ),
          _lowButton(
            "Acceder",
            () {},
          ),
        ],
      ),
    );
  }

  Widget _bunny() {
    return Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.height * 0.15,
        alignment: Alignment.center,
        child: Image(
          image: _logo,
          fit: BoxFit.fill,
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.height * 0.15,
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('assets/images/login/silhouette.png'),
          color: Colors.grey[50],
        ),
      ),
    ]);
  }

  Container _logText(
    IconData icon,
    String text,
    ValueChanged onChanged,
    IconData? tailIcon,
    bool obscure,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
          //vertical: 5,
          horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: _tertiaryColor,
        borderRadius: BorderRadius.circular(40),
      ),
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.025),
      child: TextField(
        obscureText: obscure,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: _secondaryColor,
          ),
          hintText: text,
          border: InputBorder.none,
          suffixIcon: tailIcon == null
              ? Icon(null)
              : IconButton(
                  onPressed: () {
                    obscure = !obscure;
                    //setState(() {});
                    print(obscure);
                  },
                  icon: Icon(tailIcon, color: this._secondaryColor, size: 20)),
        ),
      ),
    );
  }

  Container _lowButton(String text, Function() onPressed) {
    return Container(
      padding: EdgeInsets.symmetric(
          //vertical: 5
          horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 48,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.025),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_secondaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(10),
          ),
          overlayColor:
              MaterialStateColor.resolveWith((states) => _primaryColor),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
