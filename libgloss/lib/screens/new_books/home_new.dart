import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:libgloss/blocs/books/bloc/books_bloc.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/shared/online_image.dart';
import 'package:libgloss/widgets/shared/side_menu.dart';
import 'package:shimmer/shimmer.dart';

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
          route: LibglossRoutes.HOME_NEW,
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
    await Future.delayed(Duration(milliseconds: 1000));

    BlocProvider.of<BooksBloc>(context).add(GetRandomBooksEvent(
      page_size: 16,
    ));

    _refreshController.refreshCompleted();
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
          return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: GridView(
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
                children: List.generate(
                  10,
                  (index) => Container(
                    color: Colors.teal[100],
                    child: Column(
                      children: [
                        Container(
                          height: (MediaQuery.of(context).size.height / 4.7),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
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

  Column _found(BuildContext context, List<dynamic> books) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
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
                child: GridView.builder(
                  padding: EdgeInsets.all(20),
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 18,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.3),
                  ),
                  itemCount: books.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("$index = ${books[index]["categories"]}");
                    return _gender(context, books, index);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _gender(BuildContext context, List<dynamic> books, int index) {
    if (books[index]["categories"].length != 0) {
      return SizedBox(
          child:
              Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
        _card(context, books, index),
        Positioned(
          left: MediaQuery.of(context).size.height * 0.01,
          top: MediaQuery.of(context).size.height * 0.01,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.height * 0.09,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: _secondaryColor,
              ),
              child: Text(
                "${books[index]["categories"][0]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      ]));
    } else {
      return _card(context, books, index);
    }
  }

  Container _card(BuildContext context, List<dynamic> books, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                LibglossRoutes.NEW_BOOK_DETAILS,
                arguments: books[index],
              );
            },
            child: Container(
              height: (MediaQuery.of(context).size.height / 5.5),
              child: OnlineImage(
                imageUrl: books[index]["thumbnail"] ??
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/A_dictionary_of_the_Book_of_Mormon.pdf/page170-739px-A_dictionary_of_the_Book_of_Mormon.pdf.jpg",
                height: MediaQuery.of(context).size.height / 2.5, //100
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
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
  }
}
