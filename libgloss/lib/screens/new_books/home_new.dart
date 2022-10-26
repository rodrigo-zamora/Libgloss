import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:libgloss/blocs/books/bloc/books_bloc.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/shared/online_image.dart';
import 'package:libgloss/widgets/shared/side_menu.dart';

import '../../blocs/bookPrice/bloc/book_price_bloc.dart';
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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    BlocProvider.of<BooksBloc>(context).add(GetTopBooksEvent());
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    BlocProvider.of<BooksBloc>(context).add(GetTopBooksEvent());
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  // TODO: Update books list on scroll up
  Column _found(BuildContext context, List<dynamic> books) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            child: SmartRefresher(
              enablePullUp: false,
              enablePullDown: true,
              header: WaterDropMaterialHeader(
                backgroundColor: _secondaryColor,
                color: Colors.white,
              ),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
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
                            color: Colors.pink[100],
                            height: (MediaQuery.of(context).size.height / 4.7),
                            child: OnlineImage(
                              imageUrl: books[index]["thumbnail"] ??
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/A_dictionary_of_the_Book_of_Mormon.pdf/page170-739px-A_dictionary_of_the_Book_of_Mormon.pdf.jpg",
                              width:
                                  MediaQuery.of(context).size.width / 2.5, //100
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
          // TODO: Add shimmer effect
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
