import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';

import '../../blocs/details/bloc/details_bloc.dart';
import '../../config/routes.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/loading_animation.dart';
import '../../widgets/online_image.dart';
import '../../widgets/search_appbar.dart';
import '../../widgets/side_menu.dart';

// TODO: ADD BOOK API

class NewBookSearch extends StatefulWidget {
  const NewBookSearch({super.key});

  @override
  _NewBookSearchState createState() => _NewBookSearchState();
}

class _NewBookSearchState extends State<NewBookSearch> {
  final Color _primaryColor = Color.fromRGBO(199, 246, 255, 1);
  final Color _secondaryColor = Color.fromRGBO(54, 179, 201, 1);
  final Color _blueColor = Color.fromRGBO(16, 112, 130, 1);

  TextEditingController _textFieldController = TextEditingController();

  final List<Map<String, dynamic>> _listElements = [
    {
      "title": "And Then There Were None",
      "author": "Agatha Christie",
      "image": "https://m.media-amazon.com/images/I/81B9LhCS2AL.jpg",
      "isbn": "978-0062073488",
      "amazon": 100,
      "gonvill": 101,
      "gandhi": 102,
      "sotano": 103,
    },
    {
      "title": "Gone Girl",
      "author": "Gillian Flynn",
      "image": "https://m.media-amazon.com/images/I/81g5ooiHAXL.jpg",
      "isbn": "978-0307588371",
      "amazon": 201,
      "gonvill": 202,
      "gandhi": 203,
      "sotano": 204,
    },
    {
      "title": "Harry Potter and the Deahtly Hallows",
      "author": "J.K. Rowling",
      "image": "https://m.media-amazon.com/images/I/71sH3vxziLL.jpg",
      "isbn": "978-0545139700",
      "amazon": 301,
      "gonvill": 302,
      "gandhi": 303,
      "sotano": 304,
    },
    {
      "title": "Cien años de soledad",
      "author": "Gabriel García Márquez",
      "image": "https://m.media-amazon.com/images/I/81rEWmLXliL.jpg",
      "isbn": "978-1644734728",
      "amazon": 401,
      "gonvill": 402,
      "gandhi": 403,
      "sotano": 404,
    },
    {
      "title": "The Hunger Games",
      "author": "Suzanne Collins",
      "image": "https://m.media-amazon.com/images/I/61+t8dh4BEL.jpg",
      "isbn": "978-0439023481",
      "amazon": 501,
      "gonvill": 502,
      "gandhi": 503,
      "sotano": 504,
    },
    {
      "title": "The Lord of the Rings",
      "author": "J.R.R. Tolkien",
      "image":
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
            textFieldController: _textFieldController,
            showMenuButton: false,
            showCameraButton: true),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: _searchBook(context),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.HOME, iconColor: _secondaryColor),
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
          case SearchInitial:
            return Container();
          case SearchLoading:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimation(animationColor: _secondaryColor),
                  Image.asset(
                    'assets/images/loading_bunny_blue.gif',
                  ),
                ],
              ),
            );
          case SearchTempLoaded:
            return _search(context);
          default:
            return Container();
        }
      },
    );
  }

  Column _search(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "TEMPORAL SEARCH",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: _blueColor)),
              ),
              Divider(
                color: _blueColor,
                thickness: 1,
                height: 1
              ),
              _found( context),
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
                      // TODO: Checar que si este bien hecho el bloc
                      BlocProvider.of<DetailsBloc>(context).add(
                        DetailsMoveEvent(
                          list: _listElements[index]
                        ));
                      Navigator.pushNamed(
                        context, LibglossRoutes.NEW_BOOK_DETAILS,
                      );
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
    );
  }

}
