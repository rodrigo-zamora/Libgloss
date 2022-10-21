import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import 'bottom_navigation.dart';
import 'search_appbar.dart';
import 'login.dart';
import 'sign_up.dart';
import 'parts/bunny_silhouette.dart';
import 'parts/button_log.dart';


class Account extends StatefulWidget {  
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.CURRENT_ROUTE);
  final Color _secondaryColor = ColorSelector.getSecondary(LibglossRoutes.CURRENT_ROUTE);
  final Color _tertiaryColor = ColorSelector.getTertiary(LibglossRoutes.CURRENT_ROUTE);
  final Color _quaternaryColor = ColorSelector.getQuaternary(LibglossRoutes.CURRENT_ROUTE);
  final Color _iconColors = ColorSelector.getGrey();
  final AssetImage _logo = ColorSelector.getBackground(LibglossRoutes.CURRENT_ROUTE);

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
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.CURRENT_ROUTE, iconColor: _secondaryColor),
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
            }
          ),
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
            }
          ),
        ],
      ),
    );
  }
}