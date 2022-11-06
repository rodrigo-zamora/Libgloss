import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:libgloss/blocs/bookPrice/bloc/book_price_bloc.dart';
import 'package:libgloss/widgets/shared/online_image.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

class NewBookDetails extends StatefulWidget {
  NewBookDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<NewBookDetails> createState() => _NewBookDetailsState();
}

class _NewBookDetailsState extends State<NewBookDetails> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.HOME);
  final Color _secondaryColor = ColorSelector.getSecondary(LibglossRoutes.HOME);
  final Color _quaternaryColor =
      ColorSelector.getQuaternary(LibglossRoutes.HOME);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);
  final Color _redColor = ColorSelector.getRed();
  final Color _defaultColor = ColorSelector.getBlack();
  final Color _greyColor = ColorSelector.getGrey();

  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments;
    _args as Map<String, dynamic>;

    BlocProvider.of<BookPriceBloc>(context).add(
      GetBookPriceEvent(
        bookId: _args["isbn"],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: _main(context, _args),
    );
  }

  SingleChildScrollView _main(
      BuildContext context, Map<String, dynamic> _args) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _text("${_args["title"]}", _defaultColor, 20.0, FontWeight.bold,
                TextAlign.center),
            SizedBox(height: 5),
            _text("${_args["authors"].join(', ')}", _blueColor, 15.0,
                FontWeight.normal, TextAlign.center),
            SizedBox(height: 5),
            _text("${_args["isbn"]}", _defaultColor, 15.0, FontWeight.normal,
                TextAlign.center),
            SizedBox(height: 20.0),
            _image(_args["thumbnail"]! as String),
            SizedBox(height: 20.0),
            Container(
              child: _getPrices(),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // TODO: Add to wishlist
              },
              child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  alignment: Alignment.topLeft,
                  child: _text("Agregar a Lista de Deseos", _blueColor, 15.0,
                      FontWeight.bold, TextAlign.left)),
            ),
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {
                // TODO: Add to tracking list
              },
              child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  alignment: Alignment.topLeft,
                  child: _text("Hacer Seguimiento de Libro", _blueColor, 15.0,
                      FontWeight.bold, TextAlign.left)),
            ),
          ],
        ),
      ),
    );
  }

  Text _text(String text, Color color, double size, FontWeight weight,
      TextAlign align) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }

  Container _image(String image) {
    return Container(
        height: (MediaQuery.of(context).size.height / 2.5),
        child: OnlineImage(
          imageUrl: image,
          height: 100,
        ));
  }

  void _launchURL(String _url) async {
    var _arguments = {
      "url": _url,
    };
    Navigator.pushNamed(context, LibglossRoutes.WEB_VIEW,
        arguments: _arguments);
  }

  BlocConsumer<BookPriceBloc, BookPriceState> _getPrices() {
    return BlocConsumer<BookPriceBloc, BookPriceState>(
      listener: (context, state) {
        if (state is BookPriceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        double size = MediaQuery.of(context).size.height /
            MediaQuery.of(context).size.width;
        switch (state.runtimeType) {
          case BookPriceLoaded:
            final Map<String, dynamic> books = state.props[0];
            return GridView.count(
              primary: false,
              childAspectRatio: size,
              //padding: EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: <Widget>[
                for (var book in books.entries)
                  _buildCard(book.key, book.value),
              ],
            );
          case BookPriceLoading:
            return GridView.count(
              primary: false,
              childAspectRatio: size,
              //padding: EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: <Widget>[
                for (var i = 0; i < 4; i++)
                  Container(
                    child: Card(
                      elevation: 4, // the size of the shadow
                      shadowColor: _greyColor, // shadow color
                      color: _quaternaryColor, // the color of the card
                      shape: RoundedRectangleBorder(
                        // the shape of the card
                        borderRadius: BorderRadius.all(Radius.circular(
                            15)), // the radius of the border, made to be circular
                      ),
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: _secondaryColor,
                        size: size * 20,
                      ),
                    ),
                  ),
              ],
            );
          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildCard(String key, value) {
    if (value == null) {
      return _storeCard(key, _redColor, "No disponible", "");
    } else {
      return _storeCard(
          key, _blueColor, value["price"].toString(), value["url"]);
    }
  }

  Widget _storeCard(String title, Color color, String value, String url) {
    switch (title) {
      case "amazon":
        title = "Amazon";
        break;
      case "gandhi":
        title = "Gandhi";
        break;
      case "gonvill":
        title = "Gonvill";
        break;
      case "el_sotano":
        title = "El Sótano";
        break;
      case "mercado_libre":
        title = "Mercado Libre";
        break;
    }
    return Container(
      child: Card(
        elevation: 4, // the size of the shadow
        shadowColor: _greyColor, // shadow color
        color: _quaternaryColor, // the color of the card
        shape: RoundedRectangleBorder(
          // the shape of the card
          borderRadius: BorderRadius.all(Radius.circular(
              15)), // the radius of the border, made to be circular
          side: BorderSide(color: _secondaryColor, width: 0.5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (url != "") {
                    _launchURL(url);
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("No se encontró el libro en $title"),
                        ),
                      );
                  }
                },
                child: Container(
                  child: _text(
                      title, color, 15.0, FontWeight.bold, TextAlign.center),
                ),
              ),
              SizedBox(height: 5),
              _text(value, _defaultColor, 15.0, FontWeight.normal,
                  TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  /* BlocConsumer<BookPriceBloc, BookPriceState> _getPrices() {
    return BlocConsumer<BookPriceBloc, BookPriceState>(
      listener: (context, state) {
        if (state is BookPriceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case BookPriceLoaded:
            final Map<String, dynamic> books = state.props[0];
            for (var book in books.entries)
              print(book.key + " " + book.value.toString());
            return Table(
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 0.5),
              children: [
                for (var book in books.entries) _buildRow(book.key, book.value),
              ],
            );
          case BookPriceLoading:
            Widget _loadingShimmer = Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.white,
                height: 100,
                width: 100,
              ),
            );
            return Table(
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 0.5),
              children: [
                for (var i = 0; i < 5; i++)
                  TableRow(children: [
                    TableCell(
                      child: Container(
                        height: 25,
                        padding: EdgeInsets.all(5.0),
                        child: _loadingShimmer,
                      ),
                    ),
                    TableCell(
                      child: Container(
                        height: 25,
                        padding: EdgeInsets.all(5.0),
                        child: _loadingShimmer,
                      ),
                    ),
                  ]),
              ],
            );
          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildRow(String key, value) {
    if (value == null) {
      return _row(key, _redColor, "No disponible", "");
    } else {
      return _row(key, _blueColor, value["price"].toString(), value["url"]);
    }
  }

  TableRow _row(String title, Color color, String value, String url) {
    switch (title) {
      case "amazon":
        title = "Amazon";
        break;
      case "gandhi":
        title = "Gandhi";
        break;
      case "gonvill":
        title = "Gonvill";
        break;
      case "el_sotano":
        title = "El Sótano";
        break;
      case "mercado_libre":
        title = "Mercado Libre";
        break;
    }
    return TableRow(children: [
      TableCell(
        child: GestureDetector(
          onTap: () {
            if (url != "") {
              _launchURL(url);
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("No se encontró el libro en $title"),
                  ),
                );
            }
          },
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: _text(title, color, 15.0, FontWeight.bold, TextAlign.center),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: _text(
              value, _defaultColor, 15.0, FontWeight.normal, TextAlign.center),
        ),
      ),
    ]);
  } */
}
