import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libgloss/blocs/auth/bloc/auth_bloc.dart';
import 'package:libgloss/blocs/used_books/bloc/used_books_bloc.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';
import 'package:libgloss/widgets/shared/side_menu.dart';

import 'package:libgloss/blocs/bookISBN/bloc/book_isbn_bloc.dart';
import 'package:libgloss/widgets/shared/online_image.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';

class HomeUsed extends StatefulWidget {
  HomeUsed({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeUsed> createState() => _HomeUsedState();
}

class _HomeUsedState extends State<HomeUsed> {
  final Color _primaryColor = AppColor.getPrimary(Routes.usedBooks);
  final Color _secondaryColor = AppColor.getSecondary(Routes.usedBooks);
  final Color _blueColor = AppColor.getTertiary(Routes.home);
  final Color _greenColor = AppColor.getTertiary(Routes.usedBooks);

  List<Map<String, dynamic>> _listElements = [];
  Map<String, dynamic>? isSeller = {};

  @override
  Widget build(BuildContext context) {
    isSeller!['isSeller'] = true;

    // TODO: Get used books from Amplify database

    return _buildSellingPage();
  }

  Widget _loadingPage() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: true,
          showCameraButton: false,
          showSearchField: true,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: Center(
        child: CircularProgressIndicator(color: _secondaryColor),
      ),
    );
  }

  Widget _buildSellingPage() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: true,
          showCameraButton: false,
          showSearchField: true,
          route: Routes.usedBooks,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
        route: Routes.usedBooks,
      ),
      body: _add(context),
    );
  }

  SizedBox _add(context) {
    return SizedBox(
        child: Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
      _found(context),
      isSeller != null ? _button(isSeller?['isSeller']) : Container(),
    ]));
  }

  Widget _button(bool isSeller) {
    if (BlocProvider.of<AuthBloc>(context).isSigned && isSeller) {
      return Positioned(
        bottom: MediaQuery.of(context).size.height * 0.03,
        right: MediaQuery.of(context).size.height * 0.03,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.height * 0.06,
          child: FloatingActionButton(
            heroTag: "btn2",
            backgroundColor: _primaryColor,
            splashColor: _secondaryColor,
            onPressed: () {
              _openCamera();
            },
            child: FaIcon(
              //Icons.photo_camera_outlined,
              FontAwesomeIcons.plus,
              color: _greenColor,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Column _found(BuildContext context) {
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
                crossAxisSpacing: 15,
                mainAxisSpacing: 18,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.22),
              ),
              itemCount: _listElements.length,
              itemBuilder: (BuildContext context, int index) {
                return _card(index, context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Container _card(int index, BuildContext context) {
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
                Routes.usedBookDetails,
                arguments: _listElements[index],
              );
            },
            child: Column(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height / 5.5),
                  child: OnlineImage(
                    imageUrl: _listElements[index]["images"][0],
                    height: (MediaQuery.of(context).size.height / 5.5),
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
                  "${_listElements[index]["authors"].join(', ')}",
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
                  "${_listElements[index]["seller"]}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _greenColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openCamera() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            contentPadding: EdgeInsets.all(22.0),
            title: Text("Abrir cámara"),
            content: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Para subir un libro se necesita escanear el '),
                  TextSpan(
                      text: 'código de barras',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: ' del mismo\nSerá redirigido al scan de cámara '),
                  TextSpan(
                      text: '¿Desea continuar?',
                      style: TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: Text("Cancelar", style: TextStyle(color: _greenColor)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  _openCode();
                },
                child: Text("Ingresar código manualmente",
                    style: TextStyle(color: _greenColor)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  Navigator.pushNamed(context, Routes.usedBookScanner);
                },
                child: Text("Continuar", style: TextStyle(color: _greenColor)),
              ),
            ],
          );
        });
  }

  void _openCode() {
    TextEditingController _isbnController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            contentPadding: EdgeInsets.all(22.0),
            title: Text("Ingresar código ISNB"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Para subir un libro se necesita ingresar el '),
                      TextSpan(
                          text: 'código ISBN-13',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ' del mismo.\nFavor de ingresarlo en el campo de texto '),
                    ],
                  ),
                ),
                /* TextFormField(
                controller: _isbnController,//user[0]['zipCode'] == null ? _zpController : _zpController = TextEditingController(text: user[0]['zipCode']),
                keyboardType: TextInputType.number,
                maxLength: 13,
                /* validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un código ISBN-13';
                  }
                  if (value.length < 13 || value.length > 13) {
                    return 'El código ISBN-13 debe tener 13 dígitos';
                  }
                  return null;
                }, */
                decoration: InputDecoration(
                  hintText: "Código ISBN-13",
                ),
                validator: (String? value) {
                  return (value != null && value.length != 13) ? 'Do not use the @ char.' : null;
                },
              ), */
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 13,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Favor de ingresar un código ISBN-13';
                          }
                          if (value.length < 13 || value.length > 13) {
                            return 'El código ISBN-13 debe tener 13 dígitos';
                          }
                          return null;
                        },
                      ),
                      Row(
                          //padding: EdgeInsets.symmetric(vertical: 16.0),
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Cancel');
                              },
                              child: Text("Cancelar",
                                  style: TextStyle(color: _greenColor)),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')),
                                  );
                                }
                                //TODO: Arreglar el código para que sí mande la info del bloc
                                _getBookDetails(_isbnController.text);
                              },
                              child: Text('Continuar',
                                  style: TextStyle(color: _greenColor)),
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _provider(String text) {
    final String code = text;
    BlocProvider.of<BookIsbnBloc>(context).add(ClearBookDetailsEvent());
    BlocProvider.of<BookIsbnBloc>(context).add(GetBookDetailsEvent(
      isbn: code,
    ));
    print("ISBN: $code");
  }

  BlocConsumer<BookIsbnBloc, BookIsbnState> _getBookDetails(String code) {
    return BlocConsumer<BookIsbnBloc, BookIsbnState>(
      listener: (context, state) {
        if (state is BookIsbnError) {
          BlocProvider.of<BookIsbnBloc>(context).add(ClearBookDetailsEvent());
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        } else if (state is BookIsbnInitial) {
          _provider(code);
        } else if (state is BookIsbnLoaded) {
          var books = state.bookDetails;
          print(books);
        }
      },
      builder: (context, state) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  BlocConsumer<UsedBooksBloc, UsedBooksState> _getBooks(BuildContext context) {
    return BlocConsumer<UsedBooksBloc, UsedBooksState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UsedBooksLoaded) {
          _listElements = state.usedBooks;
          return _buildSellingPage();
        } else if (state is UsedBooksError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
