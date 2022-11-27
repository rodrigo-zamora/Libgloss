import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
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
          LibglossRoutes.getRoute(LibglossRoutes.LOGIN),
        ];

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      print("[Awesome Notifications] isAllowed: $isAllowed");
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    String firebaseToken =
        await AwesomeNotificationsFcm().requestFirebaseAppToken();
    print("[Awesome Notifications] Firebase Token: $firebaseToken");

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
