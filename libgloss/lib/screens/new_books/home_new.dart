import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/shared/online_image.dart';
import 'package:libgloss/widgets/shared/side_menu.dart';

import '../../config/colors.dart';
import '../../widgets/shared/search_appbar.dart';

class HomeNew extends StatefulWidget {
  HomeNew({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeNew> createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {

  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.HOME);
  final Color _secondaryColor = ColorSelector.getSecondary(LibglossRoutes.HOME);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);

  // TODO: Get list of books from database
  final List<Map<String, dynamic>> _listElements = [
    {
      "title": "And Then There Were None",
      "author": "Agatha Christie",
      "thumbnail": "https://m.media-amazon.com/images/I/81B9LhCS2AL.jpg",
      "isbn": "978-0062073488",
      "amazon": 100,
      "gonvill": 101,
      "gandhi": 102,
      "sotano": 103,
    },
    {
      "title": "Gone Girl",
      "author": "Gillian Flynn",
      "thumbnail": "https://m.media-amazon.com/images/I/81g5ooiHAXL.jpg",
      "isbn": "978-0307588371",
      "amazon": 201,
      "gonvill": 202,
      "gandhi": 203,
      "sotano": 204,
    },
    {
      "title": "Harry Potter and the Deahtly Hallows",
      "author": "J.K. Rowling",
      "thumbnail": "https://m.media-amazon.com/images/I/71sH3vxziLL.jpg",
      "isbn": "978-0545139700",
      "amazon": 301,
      "gonvill": 302,
      "gandhi": 303,
      "sotano": 304,
    },
    {
      "title": "Cien años de soledad",
      "author": "Gabriel García Márquez",
      "thumbnail": "https://m.media-amazon.com/images/I/81rEWmLXliL.jpg",
      "isbn": "978-1644734728",
      "amazon": 401,
      "gonvill": 402,
      "gandhi": 403,
      "sotano": 404,
    },
    {
      "title": "The Hunger Games",
      "author": "Suzanne Collins",
      "thumbnail": "https://m.media-amazon.com/images/I/61+t8dh4BEL.jpg",
      "isbn": "978-0439023481",
      "amazon": 501,
      "gonvill": 502,
      "gandhi": 503,
      "sotano": 504,
    },
    {
      "title": "The Lord of the Rings",
      "author": "J.R.R. Tolkien",
      "thumbnail":
          "https://m.media-amazon.com/images/I/51kfFS5-fnL._SX332_BO1,204,203,200_.jpg",
      "isbn": "978-0544003415",
      "amazon": 601,
      "gonvill": 602,
      "gandhi": 603,
      "sotano": 604,
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
          showMenuButton: true,
          showCameraButton: true,
          showSearchField: true,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: _found(context),
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
                          if (kDebugMode)
                            print(
                                "[HomeNew] Moving to details of ${_listElements[index]["title"]}");
                          Navigator.pushNamed(
                            context,
                            LibglossRoutes.NEW_BOOK_DETAILS,
                            arguments: _listElements[index],
                          );
                        },
                        child: Container(
                          height: (MediaQuery.of(context).size.height / 4.7),
                          child: OnlineImage(
                            imageUrl: _listElements[index]["thumbnail"]!,
                            width: 100,
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
