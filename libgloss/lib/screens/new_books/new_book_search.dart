import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/bookPrice/bloc/book_price_bloc.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/animations/loading_animation.dart';
import '../../widgets/shared/online_image.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewBookSearch extends StatefulWidget {
  const NewBookSearch({super.key});

  @override
  _NewBookSearchState createState() => _NewBookSearchState();
}

class _NewBookSearchState extends State<NewBookSearch> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.HOME);
  final Color _secondaryColor = ColorSelector.getSecondary(LibglossRoutes.HOME);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);

  String _initialFilter = 'Más relevantes';

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
          showBackButton: true,
          route: LibglossRoutes.HOME_NEW,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
        route: LibglossRoutes.HOME_NEW,
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
                    'assets/images/loading/loading_bunny_blue.gif',
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
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Ordenar por:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _blueColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _initialFilter,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    borderRadius: BorderRadius.circular(10),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    underline: Container(
                      height: 2,
                      color: _blueColor,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _initialFilter = newValue!;
                      });
                    },
                    items: [
                      'Más relevantes',
                      'Mejor calificación',
                      'Peor calificación',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 10),
                ],
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
    List<dynamic> _books = [...books];

    print("\u001b[32m[Filter] Selected filter: $_initialFilter");
    switch (_initialFilter) {
      case "Mejor calificación":
        print("\u001b[32m[Filter] Sorting by best rating");
        // Sort by best rating, from highest to lowest, nulls last
        _books.sort((a, b) => (b['rating'] ?? 0).compareTo(a['rating'] ?? 0));
        break;
      case "Peor calificación":
        print("\u001b[32m[Filter] Sorting by worst rating");
        _books.sort((a, b) => (a["rating"] == null)
            ? 1
            : (b["rating"] == null)
                ? -1
                : a["rating"]!.compareTo(b["rating"]!));
        break;
      default:
        print("\u001b[32m[Filter] Sorting by relevance");
        break;
    }

    print("\u001b[32m[Filter] Books before sorting: $books");
    print("\u001b[32m[Filter] Books after sorting: $_books");

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
          itemCount: _books.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              //color: Colors.teal[100],
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<BookPriceBloc>(context).add(
                        GetBookPriceEvent(
                          bookId: _books[index]["isbn"],
                        ),
                      );
                      Navigator.pushNamed(
                        context,
                        LibglossRoutes.NEW_BOOK_DETAILS,
                        arguments: _books[index],
                      );
                    },
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 6),
                      child: OnlineImage(
                          imageUrl: _books[index]["thumbnail"] != null
                              ? _books[index]["thumbnail"]
                              : "https://vip12.hachette.co.uk/wp-content/uploads/2018/07/missingbook.png",
                          height: MediaQuery.of(context).size.height / 3.5),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${_books[index]["title"]}",
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
                    "${_books[index]["authors"].join(', ')}",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_books[index]["rating"] != null)
                        // Display rating, use half stars if decimal
                        RatingBarIndicator(
                          rating: _books[index]["rating"]!.toDouble(),
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 213, 131, 22),
                            );
                          },
                          itemCount: 5,
                          itemSize: 24.0,
                          direction: Axis.horizontal,
                        ),
                      if (_books[index]["rating"] == null)
                        Text(
                          "Sin calificación",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                          ),
                        ),
                    ],
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
