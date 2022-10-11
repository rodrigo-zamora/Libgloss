import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/online_image.dart';
import 'package:libgloss/widgets/side_menu.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';
import 'new_book_details.dart';

class HomeNew extends StatefulWidget {
  HomeNew({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeNew> createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  final Color _primaryColor = Color.fromRGBO(199, 246, 255, 1);
  final Color _secondaryColor = Color.fromRGBO(54, 179, 201, 1);
  final Color _blueColor = Color.fromRGBO(16, 112, 130, 1);

  TextEditingController _textFieldController = TextEditingController();

  final List<Map<String, String>> _listElements = [
    {
      "title": "And Then There Were None",
      "author": "Agatha Christie",
      "image": "https://m.media-amazon.com/images/I/81B9LhCS2AL.jpg",
      "isbn": "978-0062073488",
    },
    {
      "title": "Gone Girl",
      "author": "Gillian Flynn",
      "image": "https://m.media-amazon.com/images/I/81g5ooiHAXL.jpg",
      "isbn": "978-0307588371",
    },
    {
      "title": "Harry Potter and the Deahtly Hallows",
      "author": "J.K. Rowling",
      "image": "https://m.media-amazon.com/images/I/71sH3vxziLL.jpg",
      "isbn": "978-0545139700",
    },
    {
      "title": "Cien años de soledad",
      "author": "Gabriel García Márquez",
      "image": "https://m.media-amazon.com/images/I/81rEWmLXliL.jpg",
      "isbn": "978-1644734728",
    },
    {
      "title": "The Hunger Games",
      "author": "Suzanne Collins",
      "image": "https://m.media-amazon.com/images/I/61+t8dh4BEL.jpg",
      "isbn": "978-0439023481",
    },
    {
      "title": "The Lord of the Rings",
      "author": "J.R.R. Tolkien",
      "image":
          "https://m.media-amazon.com/images/I/51kfFS5-fnL._SX332_BO1,204,203,200_.jpg",
      "isbn": "978-0544003415",
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
            showCameraButton: true),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: _found(context),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.HOME, iconColor: _secondaryColor),
    );
  }

  Column _found(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 18,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.5),
              ),
              itemCount: _listElements.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  //color: Colors.teal[100],
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print(_listElements[index]["title"]);
                          // TODO: Add bloc event to search _listElements[index]["title"]
                        },
                        child: Container(
                          height: (MediaQuery.of(context).size.height / 4.7),
                          child: OnlineImage(
                            imageUrl: _listElements[index]["image"]!,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${_listElements[index]["title"]}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${_listElements[index]["author"]}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _blueColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
