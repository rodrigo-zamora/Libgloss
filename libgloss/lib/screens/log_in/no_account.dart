import 'package:flutter/material.dart';
import 'package:libgloss/screens/log_in/account.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/search_appbar.dart';
import 'login.dart';
import 'sign_up.dart';
import 'parts/bunny_silhouette.dart';
import 'parts/button_log.dart';

class NoAccount extends StatefulWidget {
  NoAccount({super.key});

  @override
  State<NoAccount> createState() => _NoAccountState();
}

class _NoAccountState extends State<NoAccount> {
  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.CURRENT_ROUTE);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.CURRENT_ROUTE);
  final Color _tertiaryColor =
      ColorSelector.getTertiary(LibglossRoutes.CURRENT_ROUTE);
  final Color _quaternaryColor =
      ColorSelector.getQuaternary(LibglossRoutes.CURRENT_ROUTE);
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
          Text(
            'No estas logueado',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _secondaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Necesitas iniciar sesión para poder ver esta sección',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _tertiaryColor,
                fontSize: 20,
                fontStyle: FontStyle.italic),
          ),
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
              text: "¡Ir a Iniciar Sesión!",
              onPressed: () {
                LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.OPTIONS;
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Account(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              }),
          ButtonLog(
              context: context,
              background: _primaryColor,
              splash: _primaryColor,
              text_color: _tertiaryColor,
              text: "Acceso temporal para ver seguimientos",
              onPressed: () {
                Navigator.pushNamed(context, LibglossRoutes.CURRENT_ROUTE);
              }),
        ],
      ),
    );
  }
}
