import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/filter.dart';
import '../../widgets/shared/online_image.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

class UsedBookSearch extends StatefulWidget {
  const UsedBookSearch({super.key});

  @override
  _UsedBookSearchState createState() => _UsedBookSearchState();
}

class _UsedBookSearchState extends State<UsedBookSearch> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.HOME_USED);
  final Color _secondaryColor = ColorSelector.getSecondary(LibglossRoutes.HOME_USED);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);
  final Color _greenColor = ColorSelector.getTertiary(LibglossRoutes.HOME_USED);

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
          showMenuButton: false,
          showCameraButton: false,
          showSearchField: true,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: _searchBook(context),
    );
  }

  BlocConsumer<SearchBloc, SearchState> _searchBook(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (kDebugMode)
          print(
              "\u001b[35m[SearchAppBar] Building SearchBar with state $state");
        switch (state.runtimeType) {
          case SearchLoading:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //LoadingAnimation(animationColor: _secondaryColor),
                  Image.asset(
                    'assets/images/loading_bunny_green.gif',
                  ),
                ],
              ),
            );
          case SearchLoaded:
            return _search(context);
          case SearchInitial:
          default:
            return Container();
        }
      },
    );
  }

  Column _search(BuildContext context) {
    var left = MediaQuery.of(context).size.width * 0.70;
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: left, right: 10),
                child: Filter(
                  primary: _primaryColor,
                  secondary: _secondaryColor,
                  tertiary: _greenColor,
                ),
              ),
              Divider(color: _greenColor, thickness: 1, height: 1),
              _found(context),
            ],
          ),
        ),
      ],
    );
  }

  Expanded _found(BuildContext context) {
    return Expanded(
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
    );
  }
}
