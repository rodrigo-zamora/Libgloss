import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libgloss/config/colors.dart';
import 'package:libgloss/config/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _pagesList = LibglossRoutes.getRoutesList();
  final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

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
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    print(
        LibglossRoutes.getRoutesList()[_selectedIndex].runtimeType.toString());

    Color _currentColor = ColorSelector.getSecondary(
        LibglossRoutes.getRoutesList()[_selectedIndex].runtimeType.toString());

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: _currentColor,
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
            label: isLoggedIn ? 'Mi perfil' : 'Iniciar sesión',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
