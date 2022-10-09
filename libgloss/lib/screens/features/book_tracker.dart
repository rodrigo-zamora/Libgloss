import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';
import '../../widgets/side_menu.dart';

class BookTracker extends StatelessWidget {
  final Color _primaryColor = Color.fromRGBO(244, 210, 255, 1);
  final Color _secondaryColor = Color.fromRGBO(215, 132, 243, 1);
  final Color _blueColor = Color.fromRGBO(16, 112, 130, 1);
  
  final TextEditingController _textFieldController = TextEditingController();

  BookTracker({super.key});

  final List<Map<String, String>> _listSeguimientos = [
    {
      "title": "Pet Sematary",
      "author": "Stephen King",
      "image": "https://m.media-amazon.com/images/I/713xSwL4TyL.jpg",
      "precio": "150.00",
      "plataforma": "cualquier plataforma",
      "tiempo": "3 meses",
    },
    {
      "title": "Loveless",
      "author": "Alice Oseman",
      "image": "https://m.media-amazon.com/images/I/61PpXmjK2KL.jpg",
      "precio": "250.00",
      "plataforma": "cualquier plataforma",
      "tiempo": "6 meses",
    },
    {
      "title": "Bloom",
      "author": "Kevin Panetta",
      "image": "https://m.media-amazon.com/images/I/91Sia1ZLldL.jpg",
      "precio": "190.00",
      "plataforma": "cualquier plataforma",
      "tiempo": "4 meses",
    },
  ];

  final List<Map<String, String>> _wishList = [
    {
      "title": "Gone Girl",
      "author": "Gillian Flynn",
      "image": "https://m.media-amazon.com/images/I/81g5ooiHAXL.jpg",
    },
    {
      "title": "The Girl from the Sea",
      "author": "Molly Knox Ostertag",
      "image": "https://m.media-amazon.com/images/I/71Dnpq3Tt-L.jpg",
    },
    {
      "title": "The Lord of the Rings",
      "author": "J.R.R. Tolkien",
      "image": "https://m.media-amazon.com/images/I/51kfFS5-fnL._SX332_BO1,204,203,200_.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          textFieldController: _textFieldController,
          showMenuButton: true,
          showCameraButton: false,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: _buildTrackerBody(),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.BOOK_TRACKER,
          iconColor: _secondaryColor),
    );
  }

  Widget _trackingWidget() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Seguimientos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  color: _primaryColor,
                  width: 150,
                  child: Text('Seguimiento 1'),
                ),
                Container(
                  color: _secondaryColor,
                  width: 150,
                  child: Text(
                    'Seguimiento 2',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  color: _primaryColor,
                  width: 150,
                  child: Text('Seguimiento 3'),
                ),
              ],
            )),
      ],
    );
  }

  Widget _wishListWidget() {
    return Container(
      color: _secondaryColor,
    );
  }

  Widget _buildTrackerBody() {
    return Column(children: <Widget>[
      Expanded(child: _trackingWidget()),
      Expanded(child: _wishListWidget()),
    ]);
  }
}
