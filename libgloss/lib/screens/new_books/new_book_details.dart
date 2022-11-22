import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:libgloss/blocs/bookPrice/bloc/book_price_bloc.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';
import 'package:libgloss/widgets/shared/online_image.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../blocs/tracking/bloc/tracking_bloc.dart';
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

  final TextEditingController _priceController = TextEditingController();
  int _monthsTracking = 0;
  String _storeTracking = '';

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
          showBackButton: true,
          route: LibglossRoutes.HOME_NEW,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
        route: LibglossRoutes.HOME_NEW,
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
            _image(
                _args["thumbnail"] != null ? _args["thumbnail"] as String : ""),
            SizedBox(height: 20.0),
            Container(
              child: _getPrices(),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                _wish_list(context, _args);
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
                _tracking(context, _args);
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
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
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
          case BookPriceError:
            return Container(
              child: _text("Error al obtener precios", _redColor, 15.0,
                  FontWeight.normal, TextAlign.center),
            );
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
                Container(
                  child: _text(
                      title, color, 15.0, FontWeight.bold, TextAlign.center),
                ),
                SizedBox(height: 5),
                _text(value, _defaultColor, 15.0, FontWeight.normal,
                    TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _tracking(BuildContext _context, Map<String, dynamic> _args) {
    return showDialog(
      context: _context,
      builder: (context) {
        return AlertDialog(
          title: Text("Seguimiento del libro"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: EdgeInsets.all(22.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Agrega los siguientes datos para poder "
                  "seguir el libro"),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Precio",
                      ),
                    ),
                    DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                          child: Text("Todas las tiendas"),
                          value: "all",
                        ),
                        DropdownMenuItem(
                          child: Text("Amazon"),
                          value: "amazon",
                        ),
                        DropdownMenuItem(
                          child: Text("Gandhi"),
                          value: "gandhi",
                        ),
                        DropdownMenuItem(
                          child: Text("Gonvill"),
                          value: "gonvill",
                        ),
                        DropdownMenuItem(
                          child: Text("El Sótano"),
                          value: "el_sotano",
                        ),
                      ],
                      onChanged: (value) {
                        _storeTracking = value!;
                      },
                      decoration: InputDecoration(
                        labelText: "Tienda",
                      ),
                    ),
                    DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                          child: Text("1 mes"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("3 meses"),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text("6 meses"),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          child: Text("1 año"),
                          value: 12,
                        ),
                      ],
                      onChanged: (value) {
                        _monthsTracking = value!;
                      },
                      decoration: InputDecoration(
                        labelText: "Tiempo",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                var isLoggedIn =
                    (await UserAuthRepository().getInstance().currentUser);
                print("[TrackingList] Adding book to wish list");
                print("[TrackingList] User uid: $isLoggedIn");

                if (isLoggedIn == null) {
                  print("[TrackingList] User not logged in");
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text("Debes iniciar sesión para agregar "
                            "libros a tu lista de seguimiento"),
                      ),
                    );
                } else {
                  print("[TrackingList] User logged in");
                  String uid = isLoggedIn.uid;
                  print("[TrackingList] User uid: $uid");

                  print(
                      "[TrackingList] Adding book to wish list: ${_args["isbn"]}");

                  print(
                      "[TrackingList] Checking if book is already in tracking list");

                  String? useruid =
                      UserAuthRepository.userInstance?.currentUser!.uid;

                  var book = await FirebaseFirestore.instance
                      .collection("lists")
                      .where("useruid", isEqualTo: useruid)
                      .get();
                  List<DocumentSnapshot> booksList = book.docs;

                  List<dynamic> books = booksList[0]["tracking"];
                  print("[TrackingList] Books in tracking list: $books");

                  bool isAlreadyInList = false;
                  for (var book in books) {
                    if (book["isbn"] == _args["isbn"]) {
                      isAlreadyInList = true;
                      print("[TrackingList] Book is already in tracking list");
                      break;
                    }
                  }

                  if (!isAlreadyInList) {
                    print("[TrackingList] Adding book to tracking list");
                    await FirebaseFirestore.instance
                        .collection("lists")
                        .doc(booksList[0].id)
                        .update({
                      "tracking": FieldValue.arrayUnion([
                        {
                          "isbn": _args["isbn"],
                          "title": _args["title"],
                          "authors": _args["authors"],
                          "price": int.parse(_priceController.text),
                          "time": _monthsTracking,
                          "thumbnail": _args["thumbnail"],
                          "store": _storeTracking,
                        }
                      ])
                    });
                    print("[TrackingList] Book added to tracking list");
                    ScaffoldMessenger.of(_context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content:
                              Text("Libro agregado a tu lista de seguimiento"),
                        ),
                      );
                    BlocProvider.of<TrackingBloc>(_context)
                        .add(UpdateTracking());
                  } else {
                    print("[TrackingList] Book is already in tracking list");
                    ScaffoldMessenger.of(_context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("El libro ya se encuentra en tu lista "
                              "de seguimiento"),
                        ),
                      );
                  }
                }
              },
              child: Text("Agregar"),
            )
          ],
        );
      },
    );
  }

  Future<dynamic> _wish_list(
      BuildContext _context, Map<String, dynamic> _args) {
    return showDialog(
        context: _context,
        builder: (context) {
          return AlertDialog(
            title: Text("Agregar a la lista de deseos"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            contentPadding: EdgeInsets.all(22.0),
            content: Text(
                "¿Estás seguro que deseas agregar este libro a tu lista de deseos?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  var isLoggedIn =
                      (await UserAuthRepository().getInstance().currentUser);
                  print("[WishList] Adding book to wish list");
                  print("[WishList] User uid: $isLoggedIn");

                  if (isLoggedIn == null) {
                    print("[WishList] User not logged in");
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("Debes iniciar sesión para agregar "
                              "libros a tu lista de deseos"),
                        ),
                      );
                  } else {
                    print("[WishList] User logged in");
                    String uid = isLoggedIn.uid;
                    print("[WishList] User uid: $uid");

                    print(
                        "[WishList] Adding book to wish list: ${_args["isbn"]}");

                    print(
                        "[WishList] Checking if book is already in wish list");
                    String? useruid =
                        UserAuthRepository.userInstance?.currentUser!.uid;
                    var book = await FirebaseFirestore.instance
                        .collection("lists")
                        .where("useruid", isEqualTo: useruid)
                        .get();
                    List<DocumentSnapshot> bookList = book.docs;

                    List<dynamic> books = bookList[0]["wish"];
                    print("[WishList] Book list: $books");

                    bool isBookInList = false;
                    for (var book in books) {
                      if (book["isbn"] == _args["isbn"]) {
                        isBookInList = true;
                        print("[WishList] Book is already in wish list");
                        break;
                      }
                    }

                    if (!isBookInList) {
                      print("[WishList] Adding book to wish list");
                      FirebaseFirestore.instance
                          .collection("lists")
                          .doc(bookList[0].id)
                          .update({
                        "wish": FieldValue.arrayUnion([
                          {
                            "isbn": _args["isbn"],
                            "title": _args["title"],
                            "authors": _args["authors"],
                            "thumbnail": _args["thumbnail"],
                          }
                        ])
                      }).then((value) {
                        print("[WishList] Book added to wish list");
                        ScaffoldMessenger.of(_context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content:
                                  Text("Libro agregado a tu lista de deseos"),
                            ),
                          );
                        BlocProvider.of<TrackingBloc>(_context)
                            .add(UpdateTracking());
                      }).catchError((error) {
                        print("[WishList] Error adding book to wish list");
                        print("[WishList] Error: $error");
                        ScaffoldMessenger.of(_context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content:
                                  Text("Error agregando libro a tu lista de "
                                      "deseos"),
                            ),
                          );
                      });
                    } else {
                      ScaffoldMessenger.of(_context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content:
                                Text("El libro ya se encuentra en tu lista "
                                    "de deseos"),
                          ),
                        );
                    }
                  }
                },
                child: Text("Agregar"),
              ),
            ],
          );
        });
  }
}
