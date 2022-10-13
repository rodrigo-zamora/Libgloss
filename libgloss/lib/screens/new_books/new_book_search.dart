import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';

import '../../config/routes.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/loading_animation.dart';
import '../../widgets/search_appbar.dart';
import '../../widgets/side_menu.dart';

// TODO: ADD BOOK API

class NewBookSearch extends StatefulWidget {
  const NewBookSearch({super.key});

  @override
  _NewBookSearchState createState() => _NewBookSearchState();
}

class _NewBookSearchState extends State<NewBookSearch> {
  final Color _primaryColor = Color.fromRGBO(199, 246, 255, 1);
  final Color _secondaryColor = Color.fromRGBO(54, 179, 201, 1);

  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
            primaryColor: _primaryColor,
            secondaryColor: _secondaryColor,
            textFieldController: _textFieldController,
            showMenuButton: false,
            showCameraButton: true),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: _searchBook(context),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.HOME, iconColor: _secondaryColor),
    );
  }

  BlocConsumer<SearchBloc, SearchState> _searchBook(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (kDebugMode)
          print(
              "\u001b[35m[SearchAppBar] Building SearchBar with state $state");
        switch (state.runtimeType) {
          case SearchInitial:
            return Container();
          case SearchLoading:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimation(animationColor: _secondaryColor),
                  Image.asset(
                    'assets/images/loading_bunny_blue.gif',
                  ),
                ],
              ),
            );
          default:
            return Container();
        }
      },
    );
  }

}
