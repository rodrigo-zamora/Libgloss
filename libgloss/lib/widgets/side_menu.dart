import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Drawer(
        child: ListView(
          children: [
            Column(
              children: [
                _buildCategoryList(
                  "Género",
                  [
                    "Acción",
                    "Aventura",
                    "Ciencia Ficción",
                    "Fantasía",
                    "Historia",
                    "Misterio",
                    "Romance",
                    "Terror",
                  ],
                ),
                _buildCategoryList(
                  "Autor",
                  [
                    "Agatha Christie",
                    "Aldous Huxley",
                    "Edgar Allan Poe",
                    "George Orwell",
                    "J. R. R. Tolkien",
                    "J. K. Rowling",
                    "J. D. Salinger",
                    "Jane Austen",
                  ],
                ),
                _buildCategoryList(
                  "Rango de precios",
                  [
                    "Menos de \$100",
                    "Entre \$100 y \$200",
                    "Entre \$200 y \$300",
                    "Entre \$300 y \$400",
                    "Entre \$400 y \$500",
                    "Más de \$500",
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
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
          trailing: IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: () {},
          ),
          onTap: () {
            // TODO: Implement expand/collapse functionality
          },
        ),
        for (var item in categoryItems) _buildCategoryItem(item),
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
}
