import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/search_appbar.dart';
import '../parts/bunny_silhouette.dart';
import '../parts/button_log.dart';

class Account extends StatefulWidget {
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.OPTIONS);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.OPTIONS);
  final Color _tertiaryColor =
      ColorSelector.getTertiary(LibglossRoutes.OPTIONS);
  final Color _quaternaryColor =
      ColorSelector.getQuaternary(LibglossRoutes.OPTIONS);
  final Color _iconColors = ColorSelector.getGrey();
  final AssetImage _logo = ColorSelector.getBackground(LibglossRoutes.OPTIONS);

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
          BunnySilhouette(context: context, logo: _logo),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          ButtonLog(
              context: context,
              background: _secondaryColor,
              splash: _primaryColor,
              text_color: _quaternaryColor,
              text: "Iniciar sesión",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  LibglossRoutes.LOGIN,
                );
              }),
          ButtonLog(
              context: context,
              background: _primaryColor,
              splash: _secondaryColor,
              text_color: _tertiaryColor,
              text: "Regístrate",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  LibglossRoutes.SIGN_UP,
                );
              }),
        ],
      ),
    );
  }
}
