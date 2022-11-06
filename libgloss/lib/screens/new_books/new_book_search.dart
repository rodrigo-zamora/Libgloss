import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/bookPrice/bloc/book_price_bloc.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/animations/loading_animation.dart';
import '../../widgets/shared/filter.dart';
import '../../widgets/shared/online_image.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

class NewBookSearch extends StatefulWidget {
  const NewBookSearch({super.key});

  @override
  _NewBookSearchState createState() => _NewBookSearchState();
}

class _NewBookSearchState extends State<NewBookSearch> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.HOME);
  final Color _secondaryColor = ColorSelector.getSecondary(LibglossRoutes.HOME);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: false,
          showCameraButton: true,
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
      listener: (context, state) {
        if (state is SearchError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        }
      },
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
          case SearchLoaded:
            return _search(context, state.props[0]);
          default:
            return Container();
        }
      },
    );
  }

  Column _search(BuildContext context, List<dynamic> books) {
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
                  tertiary: _blueColor,
                ),
              ),
              Divider(color: _blueColor, thickness: 1, height: 1),
              _found(context, books),
            ],
          ),
        ),
      ],
    );
  }

  Expanded _found(BuildContext context, List<dynamic> books) {
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
                      BlocProvider.of<BookPriceBloc>(context).add(
                        GetBookPriceEvent(
                          bookId: books[index]["isbn"],
                        ),
                      );
                      Navigator.pushNamed(
                        context,
                        LibglossRoutes.NEW_BOOK_DETAILS,
                        arguments: books[index],
                      );
                    },
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 4.7),
                      child: OnlineImage(
                        imageUrl: books[index]["thumbnail"] != null
                            ? books[index]["thumbnail"]
                            : "https://vip12.hachette.co.uk/wp-content/uploads/2018/07/missingbook.png",
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
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${books[index]["authors"].join(', ')}",
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
