import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/config/routes.dart';

import '../../blocs/search/bloc/search_bloc.dart';

class SearchAppBar extends StatelessWidget {
  SearchAppBar({
    Key? key,
    required Color primaryColor,
    required Color secondaryColor,
    required bool showMenuButton,
    required bool showCameraButton,
    required bool showSearchField,
  })  : _primaryColor = primaryColor,
        _secondaryColor = secondaryColor,
        _showMenuButton = showMenuButton,
        _showCameraButton = showCameraButton,
        _showSearchField = showSearchField,
        _textFieldController = TextEditingController(),
        super(key: key);

  final TextEditingController _textFieldController;
  final Color _primaryColor;
  final Color _secondaryColor;
  final bool _showMenuButton;
  final bool _showCameraButton;
  final bool _showSearchField;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _primaryColor,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: _primaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      flexibleSpace: SafeArea(
        child: _buildSearchBar(context),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (_showMenuButton)
              Container(
                width: MediaQuery.of(context).size.width * 0.12,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            if (!_showMenuButton)
              Container(
                width: MediaQuery.of(context).size.width * 0.12,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                    switch (LibglossRoutes.CURRENT_ROUTE) {
                      case LibglossRoutes.SEARCH_NEW:
                        LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.HOME;
                        break;
                      case LibglossRoutes.SEARCH_USED:
                        LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.HOME_USED;
                        break;
                    }
                  },
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.83,
                  height: 30,
                  child: _buildSearchField(context),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Container(
                  height: 32,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  color: _secondaryColor,
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Image.asset(
                      'assets/images/icon/onlybunny.png',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchField(context) {
    if (!_showSearchField)
      return Container(
        alignment: Alignment.center,
        child: Text(
          'Escanea un código de barras',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      );
    else
      return TextField(
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical(y: 1),
        controller: _textFieldController,
        onSubmitted: (value) {
          // TODO: Add filters to search
          Map<String, dynamic> filters = {};

          if (kDebugMode)
            print(
                "\u001b[32m[SearchAppBar] Current screen is ${LibglossRoutes.CURRENT_ROUTE}");
          if (LibglossRoutes.CURRENT_ROUTE == LibglossRoutes.HOME) {
            Navigator.pushNamed(
              context,
              LibglossRoutes.SEARCH_NEW,
              arguments: filters,
            );
          }
          if (LibglossRoutes.CURRENT_ROUTE == LibglossRoutes.HOME_USED) {
            Navigator.pushNamed(
              context,
              LibglossRoutes.SEARCH_USED,
              arguments: filters,
            );
          }

          BlocProvider.of<SearchBloc>(context).add(
            SearchBoookEvent(
              query: value,
              filters: filters,
            ),
          );
        },
        decoration: InputDecoration(
          hintText: "Buscar en Libgloss",
          suffixIcon: _showCameraButton
              ? GestureDetector(
                  child: Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 53, 53, 53),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      LibglossRoutes.SCANNER,
                    );
                  },
                )
              : null,
          hintStyle: TextStyle(
            fontSize: 15,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      );
  }
}
