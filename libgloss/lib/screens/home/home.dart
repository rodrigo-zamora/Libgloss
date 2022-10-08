import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/side_menu.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _MainPageState();
}

class _MainPageState extends State<Home> {
  Color _appBarColor = Color.fromRGBO(199, 246, 255, 1);
  TextEditingController _textFieldController = TextEditingController();

  final List<Map<String, String>> _listElements = [
    {
      "title": "And Then There Were None",
      "author": "Agatha Christie",
      "image": "https://m.media-amazon.com/images/I/81B9LhCS2AL.jpg",
    },
    {
      "title": "Gone Girl",
      "author": "Gillian Flynn",
      "image": "https://m.media-amazon.com/images/I/81g5ooiHAXL.jpg",
    },
    {
      "title": "Harry Potter and the Deahtly Hallows",
      "author": "J.K. Rowling",
      "image": "https://m.media-amazon.com/images/I/71sH3vxziLL.jpg",
    },
    {
      "title": "Cien años de soledad",
      "author": "Gabriel García Márquez",
      "image": "https://m.media-amazon.com/images/I/81rEWmLXliL.jpg",
    },
    {
      "title": "The Hunger Games",
      "author": "Suzanne Collins",
      "image": "https://m.media-amazon.com/images/I/61+t8dh4BEL.jpg",
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: _appBarColor,
    ));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
            appBarColor: _appBarColor,
            textFieldController: _textFieldController,
            showMenuButton: true,
            showCameraButton: true),
      ),
      drawer: SideMenu(),
      body: _found(context),
      bottomNavigationBar: BottomNavigation(selectedItem: LibglossRoutes.HOME),
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
                          //Navigator.pushNamed(context, "/newBookDetails");
                        },
                        child: Container(
                          height: (MediaQuery.of(context).size.height / 4.7),
                          child: Image.network(
                            "${_listElements[index]["image"]}",
                            fit: BoxFit.fill,
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
                          color: Color.fromRGBO(16, 112, 130, 1),
                          fontSize: 12,
                        ),
                      )
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
