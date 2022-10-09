import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libgloss/screens/features/book_tracker.dart';
import 'package:libgloss/screens/home/home_new.dart';
import 'package:libgloss/screens/used_book_seller.dart';
import 'package:libgloss/screens/user_options.dart';

import '../config/routes.dart';
import '../screens/home/home_used.dart';

class BottomNavigation extends StatelessWidget {
  final selectedItem;

  BottomNavigation({
    Key? key,
    required String selectedItem,
  })  : selectedItem = selectedItem,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode)
      print(
          "[BottomNavigation] Building BottomNavigationBar with selectedItem: $selectedItem");

    var _routes = {
      LibglossRoutes.HOME: 0,
      LibglossRoutes.HOME_USED: 1,
      LibglossRoutes.BOOK_TRACKER: 2,
      LibglossRoutes.OPTIONS: 3,
    };

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.book),
          label: 'Nuevos',
          //backgroundColor: Color.fromRGBO(16, 112, 130, 1),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.userGroup),
          label: 'Usados',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidBookmark),
          label: 'Seguimiento',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.gear),
          label: 'Opciones',
        ),
      ],
      currentIndex: _routes[selectedItem]!,
      selectedItemColor: Colors.black,
      onTap: (index) {
        switch (index) {
          case 0:
            if (kDebugMode) print('[BottomNavigation] Redirecting to Home');
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => HomeNew(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            break;
          case 1:
            if (kDebugMode) print('[BottomNavigation] Redirecting to Search');
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => HomeUsed(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            break;
          case 2:
            if (kDebugMode)
              print('[BottomNavigation] Redirecting to BookTracker');
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => BookTracker(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            break;
          case 3:
            if (kDebugMode)
              print('[BottomNavigation] Redirecting to UserOptions');
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => UserOptions(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            break;
        }
      },
    );
  }
}