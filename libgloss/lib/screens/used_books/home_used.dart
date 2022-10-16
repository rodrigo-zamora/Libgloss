import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/shared/side_menu.dart';

import '../../widgets/shared/bottom_navigation.dart';
import '../../widgets/shared/online_image.dart';
import '../../widgets/shared/search_appbar.dart';

class HomeUsed extends StatefulWidget {
  HomeUsed({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeUsed> createState() => _HomeUsedState();
}

class _HomeUsedState extends State<HomeUsed> {
  final Color _primaryColor = Color.fromRGBO(211, 241, 173, 1);
  final Color _secondaryColor = Color.fromRGBO(118, 174, 46, 1);
  final Color _blueColor = Color.fromRGBO(16, 112, 130, 1);
  final Color _greenColor = Color.fromRGBO(78, 120, 25, 1);

  final List<Map<String, dynamic>> _listElements = [
    {
      "title": "Maze Runner",
      "author": "James Dashner",
      "image": "https://m.media-amazon.com/images/I/81+462s7qWL.jpg",
      "vendedor": "Ernesto Contreras",
      "isbn": "978-6077547327",
      "precio": 100,
      "localizacion": "Guadalajara, Jalisco",
      "contacto": "1111111111",
    },
    {
      "title": "Bajo la Misma Estrella",
      "author": "John Green",
      "image":
          "https://http2.mlstatic.com/D_NQ_NP_825774-MLM49787856481_042022-V.jpg",
      "vendedor": "Lupita Gómez",
      "isbn": "978-6073114233",
      "precio": 95,
      "localizacion": "Zapopan, Jalisco",
      "contacto": "2222222222",
    },
    {
      "title": "El niño de la pijama de rayas",
      "author": "John Boyne",
      "image":
          "https://images.cdn3.buscalibre.com/fit-in/360x360/2d/84/2d845ff0cd78bb3fb398f879e3758df0.jpg",
      "vendedor": "Julian Vico",
      "isbn": "978-6073193320",
      "precio": 70,
      "localizacion": "Tlajomulco, Jalisco",
      "contacto": "3333333333",
    },
    {
      "title": "El Principito",
      "author": "Antoine de Saint-Exupéry",
      "image":
          "https://madreditorial.com/wp-content/uploads/2021/07/9788417430993-ok.png",
      "vendedor": "Maria Lucia Perera",
      "isbn": "978-6070730535",
      "precio": 50,
      "localizacion": "Tlaquepaque, Jalisco",
      "contacto": "4444444444",
    },
    {
      "title": "1984",
      "author": "George Orwell",
      "image":
          "https://images.cdn2.buscalibre.com/fit-in/360x360/3a/2c/3a2c227d11a1026b4aa3d45d33bad4f6.jpg",
      "vendedor": "Roman Dominguez",
      "isbn": "978-6073116336",
      "precio": 80,
      "localizacion": "El Salto, Jalisco",
      "contacto": "5555555555",
    },
    {
      "title": "El señor de las moscas",
      "author": "William Golding",
      "image":
          "https://http2.mlstatic.com/D_NQ_NP_906011-MLM32761111866_112019-O.jpg",
      "vendedor": "Maria Asuncion Perez",
      "isbn": "978-8420674179",
      "precio": 120,
      "localizacion": "Tonalá, Jalisco",
      "contacto": "6666666666",
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
          showCameraButton: false,
          showSearchField: true,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: _found(context),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.HOME_USED, iconColor: _secondaryColor),
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
                                "[HomeUsed] Moving to details of ${_listElements[index]["title"]}");
                          Navigator.pushNamed(
                            context,
                            LibglossRoutes.USED_BOOK_DETAILS,
                            arguments: _listElements[index],
                          );
                        },
                        child: Container(
                          height: (MediaQuery.of(context).size.height / 5.2),
                          child: OnlineImage(
                            imageUrl: "${_listElements[index]["image"]}",
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
                        //maxLines: 2,
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
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Vendido por",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${_listElements[index]["vendedor"]}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _greenColor,
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
