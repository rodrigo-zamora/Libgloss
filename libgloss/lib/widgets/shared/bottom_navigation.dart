import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libgloss/screens/tracker/book_tracker.dart';
import 'package:libgloss/screens/new_books/home_new.dart';
import 'package:libgloss/widgets/shared/login.dart';
import 'package:libgloss/screens/user/user_options.dart';

import '../../config/routes.dart';
import '../../screens/used_books/home_used.dart';

class BottomNavigation extends StatelessWidget {
  final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
  final _selectedItem;
  final Color _iconColor;

  BottomNavigation({
    Key? key,
    required String selectedItem,
    required Color iconColor,
  })  : _selectedItem = selectedItem,
        _iconColor = iconColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
          icon: FaIcon(FontAwesomeIcons.userGear),
          label: isLoggedIn ? 'Mi perfil' : 'Iniciar sesión',
        ),
      ],
      currentIndex: _routes[_selectedItem]!,
      selectedItemColor: _iconColor,
      onTap: (index) {
        // TODO: Fix navigation between all routes
        switch (index) {
          case 0:
            if (LibglossRoutes.CURRENT_ROUTE != LibglossRoutes.HOME) {
              if (kDebugMode)
                print('\u001b[36m[BottomNavigation] Redirecting to Home');
              LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.HOME;
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => HomeNew(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            } else if (LibglossRoutes.CURRENT_ROUTE == LibglossRoutes.HOME &&
                ModalRoute.of(context)?.settings.name ==
                    LibglossRoutes.NEW_BOOK_DETAILS) {
              if (kDebugMode)
                print(
                    '\u001b[36m[BottomNavigation] Redirecting to Home from NewBookDetails');
              Navigator.pop(context);
            }
            break;
          case 1:
            if (LibglossRoutes.CURRENT_ROUTE != LibglossRoutes.HOME_USED) {
              if (kDebugMode)
                print('\u001b[36m[BottomNavigation] Redirecting to Search');
              LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.HOME_USED;
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => HomeUsed(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            } else if (LibglossRoutes.CURRENT_ROUTE ==
                    LibglossRoutes.HOME_USED &&
                ModalRoute.of(context)?.settings.name ==
                    LibglossRoutes.USED_BOOK_DETAILS) {
              if (kDebugMode)
                print(
                    '\u001b[36m[BottomNavigation] Redirecting to Search from UsedBookDetails');
              Navigator.pop(context);
            }
            break;
          case 2:
            if (kDebugMode)
              print('\u001b[36m[BottomNavigation] Redirecting to BookTracker');
            LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.BOOK_TRACKER;
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
            if (isLoggedIn) {
              if (kDebugMode)
                print('\u001b[36m[BottomNavigation] Redirecting to UserOptions');
              LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.OPTIONS;
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      UserOptions(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            } else {
              if (kDebugMode)
                print('\u001b[36m[BottomNavigation] Redirecting to Login page');
              // TODO: Create login page and redirect to it
              LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.OPTIONS;
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      LogInForm(
                        route: LibglossRoutes.CURRENT_ROUTE,
                      ),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
            break;
        }
      },
    );
  }
}
