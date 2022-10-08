import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libgloss/config/routes.dart';

class BottomNavigation extends StatelessWidget {
  static final int HOME = 0;
  static final int SEARCH = 1;
  static final int BOOK_TRACKER = 2;
  static final int USER_OPTIONS = 3;

  var selectedItem = 0;

  BottomNavigation({
    selectedItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.book),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.bookOpen),
          label: 'Vendedores',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.user),
          label: 'Opciones',
        ),
      ],
      currentIndex: selectedItem,
      selectedItemColor: Colors.black,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacementNamed(LibglossRoutes.HOME);
            break;
          case 1:
            Navigator.of(context)
                .pushReplacementNamed(LibglossRoutes.USED_BOOK_SELLER);
            break;
          case 2:
            Navigator.of(context)
                .pushReplacementNamed(LibglossRoutes.BOOK_TRACKER);
            break;
          case 3:
            Navigator.of(context).pushReplacementNamed(LibglossRoutes.OPTIONS);
            break;
        }
      },
    );
  }
}
