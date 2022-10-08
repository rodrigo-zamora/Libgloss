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
          icon: FaIcon(FontAwesomeIcons.bookOpen),
          label: 'Nuevos',
          //backgroundColor: Color.fromRGBO(16, 112, 130, 1)
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.userGroup), //Icon(Icons.group_sharp),
          label: 'Usados',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmarks_sharp),// FaIcon(FontAwesomeIcons.solidBookmark),
          label: 'Seguimiento',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.gear),
          label: 'Opciones',
        ),
      ],
      currentIndex: selectedItem,
      selectedItemColor: Color.fromRGBO(16, 112, 130, 1),
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context)
              .pushReplacementNamed(LibglossRoutes.HOME);
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
            Navigator.of(context)
              .pushReplacementNamed(LibglossRoutes.OPTIONS);
            break;
        }
      },
    );
  }
}
