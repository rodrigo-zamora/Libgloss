import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/online_image.dart';
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
      "image":
          "https://m.media-amazon.com/images/I/51kfFS5-fnL._SX332_BO1,204,203,200_.jpg",
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
      body: Column(
        children: [
          Expanded(
            child: _trackingWidget(),
          ),
          Expanded(
            child: _wishListWidget(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.BOOK_TRACKER,
          iconColor: _secondaryColor),
    );
  }

  Widget _trackingBookItem(Map<String, String> item) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: OnlineImage(
                      imageUrl: item["image"]!,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        Text(
                          item["title"]!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          item["author"]!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _blueColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Plataforma: ${item["plataforma"]}",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Precio deseado: \$${item["precio"]}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tiempo: ${item["tiempo"]}",
                    style: TextStyle(
                      fontSize: 12,
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

  Widget _trackingWidget() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Text(
          'Seguimientos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var item in _listSeguimientos) _trackingBookItem(item),
            ],
          ),
        ),
      ],
    );
  }

  Widget _wishListItem(Map<String, String> item) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: OnlineImage(
                      imageUrl: item["image"]!,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        Text(
                          item["title"]!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          item["author"]!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _blueColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _wishListWidget() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Text(
          'Lista de deseos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var item in _wishList) _wishListItem(item),
            ],
          ),
        ),
      ],
    );
  }
}
