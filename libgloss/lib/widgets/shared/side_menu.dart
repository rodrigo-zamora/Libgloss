import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/search/bloc/search_bloc.dart';
import '../../config/routes.dart';

class SideMenu extends StatefulWidget {
  SideMenu({
    Key? key,
    required Color sideMenuColor,
    String? route,
  })  : _sideMenuColor = sideMenuColor,
        _route = route,
        super(key: key);

  final Color _sideMenuColor;
  final String? _route;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var mockedData = {
    "Género": {
      "isExpanded": true,
      "keyword": "category",
      "items": [
        "Acción",
        "Aventura",
        "Ciencia Ficción",
        "Fantasía",
        "Misterio",
        "Romance",
        "Terror",
        "Thriller",
        "Otros"
      ],
    },
    "Autor": {
      "isExpanded": true,
      "keyword": "author",
      "items": [
        "Agatha Christie",
        "J.K. Rowling",
        "J.R.R. Tolkien",
        "Gabriel García Márquez",
        "Suzanne Collins",
        "Gillian Flynn",
        "Otros"
      ],
    },
    "Editorial": {
      "isExpanded": true,
      "keyword": "publisher",
      "items": [
        "Alfaguara",
        "Fondo de Cultura Económica",
        "Hachette Book Group",
        "Macmillan",
        "McGraw-Hill Education",
        "Pearson",
        "Penguin Random House",
        "Scholastic",
        "Otros"
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: ListView(
          children: [
            Column(
              children: [
                _buildDrawerHeader(),
                _buildDrawerBody(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerBody() {
    for (var i = 0; i < mockedData.length; i++) {
      return Column(
        children: [
          ...mockedData.entries
              .map((e) => _buildCategoryList(
                  e.key, e.value.values.last as List<String>))
              .toList(),
        ],
      );
    }
    return Container();
  }

  Widget _buildCategoryList(String categoryName, List<String> categoryItems) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 12, top: 6),
          visualDensity: VisualDensity(
            vertical: -4,
          ),
          title: Text(
            categoryName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(Icons.expand_more),
          onTap: () {
            bool currentStatus =
                mockedData[categoryName]!["isExpanded"] as bool;
            if (kDebugMode)
              print("[SideMenu] Changing category state from " +
                  currentStatus.toString() +
                  " to " +
                  (!currentStatus).toString());
            mockedData[categoryName]!["isExpanded"] = !currentStatus;
            setState(() {});
          },
        ),
        if (mockedData[categoryName]!["isExpanded"] as bool)
          ...categoryItems
              .map(
                (e) => _buildCategoryItem(
                  e,
                  mockedData[categoryName]!["keyword"] as String,
                ),
              )
              .toList(),
      ],
    );
  }

  Widget _buildCategoryItem(String itemName, String categoryKeyword) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 24),
      visualDensity: VisualDensity(
        vertical: -4,
      ),
      title: Text(
        itemName,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
      onTap: () {
        Map<String, dynamic> filters = {};
        filters[categoryKeyword] = itemName;
        if (kDebugMode) {
          print("\u001b[32m[SideMenu] Searching with filter: " +
              filters.toString());
          print("\u001b[32m[SideMenu] Current route: " + widget._route!);
        }
        Navigator.pop(context);
        switch (widget._route) {
          case LibglossRoutes.HOME_NEW:
            Navigator.pushNamed(
              context,
              LibglossRoutes.SEARCH_NEW,
              arguments: filters,
            );
            LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.SEARCH_NEW;
            break;
          case LibglossRoutes.HOME_USED:
            Navigator.pushNamed(
              context,
              LibglossRoutes.SEARCH_USED,
              arguments: filters,
            );
            LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.SEARCH_USED;
            break;
          // Hide the side menu when the user is in the search page
          case LibglossRoutes.SEARCH_NEW:
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              LibglossRoutes.SEARCH_NEW,
              arguments: filters,
            );
            break;
          case LibglossRoutes.SEARCH_USED:
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              LibglossRoutes.SEARCH_USED,
              arguments: filters,
            );
            break;
          default:
            break;
        }
        BlocProvider.of<SearchBloc>(context).add(
          SearchBoookEvent(
            query: "",
            filters: filters,
          ),
        );
      },
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      color: widget._sideMenuColor,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/icon/onlybunny.png',
                width: 48,
                height: 48,
              ),
              Column(
                children: [
                  Text(
                    "Libgloss",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
