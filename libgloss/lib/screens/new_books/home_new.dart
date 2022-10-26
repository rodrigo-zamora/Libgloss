import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/books/bloc/books_bloc.dart';

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
      body: _getBooks(context),
    );
  }

  Column _found(BuildContext context, List<dynamic> books) {
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
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.teal[100],
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<BooksBloc>(context).add(
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
                          color: Colors.pink[100],
                          height: (MediaQuery.of(context).size.height / 4.7),
                          child: OnlineImage(
                            imageUrl: books[index]["thumbnail"]!,
                            width: MediaQuery.of(context).size.width / 2.5, //100
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
                        "${books[index]["authors"]}",
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

  BlocConsumer<BooksBloc, BooksState> _getBooks(BuildContext context) {
    return BlocConsumer<BooksBloc, BooksState>(
      listener: (context, state) {
        if (state is BooksError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is BooksLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BooksLoaded) {
          return _found(context, state.books);
        } else {
          return Center(
            child: Text("No books found"),
          );
        }
      },
    );
  }
}
