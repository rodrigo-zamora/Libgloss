import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libgloss/config/colors.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';

import '../../blocs/books/bloc/books_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _pagesList = UserAuthRepository().isAuthenticated() == true
      ? [
          LibglossRoutes.getRoute(LibglossRoutes.HOME_NEW),
          LibglossRoutes.getRoute(LibglossRoutes.HOME_USED),
          LibglossRoutes.getRoute(LibglossRoutes.BOOK_TRACKER),
          LibglossRoutes.getRoute(LibglossRoutes.OPTIONS),
        ]
      : [
          LibglossRoutes.getRoute(LibglossRoutes.HOME_NEW),
          LibglossRoutes.getRoute(LibglossRoutes.HOME_USED),
          LibglossRoutes.getRoute(LibglossRoutes.BOOK_TRACKER),
          LibglossRoutes.getRoute(LibglossRoutes.ACCOUNT),
        ];

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print

    // Get the books for the home page
    BlocProvider.of<BooksBloc>(context).add(GetRandomBooksEvent(
      page_size: 16,
    ));

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor:
            ColorSelector.getSecondary(LibglossRoutes.CURRENT_ROUTE),
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book),
            label: 'Nuevos',
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
            label: UserAuthRepository().isAuthenticated()
                ? 'Mi perfil'
                : 'Iniciar sesión',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            LibglossRoutes.CURRENT_ROUTE = _pagesList[index].toString();
          });
        },
      ),
    );
  }
}
