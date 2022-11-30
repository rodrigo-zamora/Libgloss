import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';

import '../../blocs/used_search_books/bloc/used_search_bloc.dart';
import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/online_image.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

class UsedBookSearch extends StatefulWidget {
  const UsedBookSearch({super.key});

  @override
  _UsedBookSearchState createState() => _UsedBookSearchState();
}

class _UsedBookSearchState extends State<UsedBookSearch> {
  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.HOME_USED);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.HOME_USED);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);
  final Color _greenColor = ColorSelector.getTertiary(LibglossRoutes.HOME_USED);

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
          route: LibglossRoutes.HOME_USED,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
        route: LibglossRoutes.HOME_USED,
      ),
      body: _searchBook(context),
    );
  }

  BlocConsumer<UsedSearchBloc, UsedSearchState> _searchBook(
      BuildContext context) {
    return BlocConsumer<UsedSearchBloc, UsedSearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (kDebugMode)
          print(
              "\u001b[35m[SearchAppBar] Building SearchBar with state $state");
        switch (state.runtimeType) {
          case UsedSearchLoading:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //LoadingAnimation(animationColor: _secondaryColor),
                  Image.asset(
                    'assets/images/loading/loading_bunny_green.gif',
                  ),
                ],
              ),
            );
          case UsedSearchLoaded:
            print("\u001b[35m[SearchAppBar] Building books with state $state");
            return _search(context, state.props[0]);
          default:
            return Container();
        }
      },
    );
  }

  Column _search(BuildContext context, List<Map<String, dynamic>> books) {
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
              ),
              Divider(color: _greenColor, thickness: 1, height: 1),
              _found(context, books),
            ],
          ),
        ),
      ],
    );
  }

  Expanded _found(BuildContext context, List<Map<String, dynamic>> books) {
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
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              //color: Colors.teal[100],
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print(books[index]["title"]);
                      Navigator.pushNamed(
                        context,
                        LibglossRoutes.USED_BOOK_DETAILS,
                        arguments: books[index],
                      );
                    },
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 5.2),
                      child: OnlineImage(
                        imageUrl: "${books[index]["images"][0]}",
                        height: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${books[index]["title"]}",
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
                    "${books[index]["authors"].join(", ")}",
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
                    "${books[index]["seller"]}",
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
