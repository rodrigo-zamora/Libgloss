import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  SideMenu({
    Key? key,
    required Color sideMenuColor,
  })  : _sideMenuColor = sideMenuColor,
        super(key: key);

  final Color _sideMenuColor;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var mockedData = {
    "Género": {
      "isExpanded": true,
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
    "Rango de precios": {
      "isExpanded": true,
      "items": [
        "Menos de \$100",
        "Entre \$100 y \$200",
        "Entre \$200 y \$300",
        "Entre \$300 y \$400",
        "Entre \$400 y \$500",
        "Más de \$500",
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
          ...categoryItems.map((e) => _buildCategoryItem(e)).toList(),
      ],
    );
  }

  Widget _buildCategoryItem(String itemName) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 24),
      visualDensity: VisualDensity(
        vertical: -4,
      ),
      title: Text(
        itemName,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      onTap: () {
        // TODO: Implement navigation to the selected item
      },
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      width: 200,
      color: widget._sideMenuColor,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/onlybunny.png',
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
