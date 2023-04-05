import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libgloss/blocs/auth/bloc/auth_bloc.dart';
import 'package:libgloss/blocs/books/bloc/books_bloc.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    // Get the books for the home page
    BlocProvider.of<BooksBloc>(context).add(
      const GetRandomBooksEvent(
        page_size: 16,
      ),
    );

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pagesList = BlocProvider.of<AuthBloc>(context).isSigned
        ? [
            Routes.getRoute(Routes.newBooks),
            Routes.getRoute(Routes.usedBooks),
            Routes.getRoute(Routes.bookTracker),
            Routes.getRoute(Routes.options),
          ]
        : [
            Routes.getRoute(Routes.newBooks),
            Routes.getRoute(Routes.usedBooks),
            Routes.getRoute(Routes.bookTracker),
            Routes.getRoute(Routes.login),
          ];
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.getSecondary(Routes.currentRoute),
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book),
            label: 'Nuevos',
          ),
          const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userGroup),
            label: 'Usados',
          ),
          const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidBookmark),
            label: 'Seguimiento',
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.userGear),
            label: BlocProvider.of<AuthBloc>(context).isSigned
                ? 'Mi perfil'
                : 'Iniciar sesión',
          ),
        ],
        onTap: (index) {
          setState(
            () {
              _selectedIndex = index;
              Routes.currentRoute = _pagesList[index].toString();
            },
          );
        },
      ),
    );
  }
}
