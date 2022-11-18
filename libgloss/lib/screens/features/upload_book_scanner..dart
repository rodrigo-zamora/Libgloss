import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/bookISBN/bloc/book_isbn_bloc.dart';
import 'package:libgloss/config/colors.dart';
import 'package:libgloss/models/user.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';
import 'package:libgloss/widgets/shared/online_image.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../config/routes.dart';
import '../../widgets/shared/search_appbar.dart';

class UploadBookScanner extends StatelessWidget {
  UploadBookScanner({super.key});

  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.HOME_USED);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.HOME_USED);
  final Color _greenColor = ColorSelector.getTertiary(LibglossRoutes.HOME_USED);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);
  MobileScannerController cameraController = MobileScannerController();

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
          showSearchField: false,
          title: 'Escanea un libro',
        ),
      ),
      body: _getBookDetails(context),
    );
  }

  MobileScanner _buildScanner(BuildContext context) {
    return MobileScanner(
        allowDuplicates: true,
        controller: cameraController,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('No se ha podido leer el código'),
                ),
              );
          } else {
            cameraController.dispose();
            final String code = barcode.rawValue!;
            BlocProvider.of<BookIsbnBloc>(context).add(ClearBookDetailsEvent());
            BlocProvider.of<BookIsbnBloc>(context).add(GetBookDetailsEvent(
              isbn: code,
            ));
          }
        });
  }

  BlocConsumer<BookIsbnBloc, BookIsbnState> _getBookDetails(
      BuildContext context) {
    return BlocConsumer<BookIsbnBloc, BookIsbnState>(
      listener: (context, state) {
        if (state is BookIsbnError) {
          cameraController = new MobileScannerController();
          BlocProvider.of<BookIsbnBloc>(context).add(ClearBookDetailsEvent());
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        } else if (state is BookIsbnLoaded) {
          var books = state.bookDetails;
          var image = books[0]["thumbnail"];
          var imageHolder;
          if (image == null) {
            imageHolder = Image.asset(
              'assets/images/special/not_found.png',
            );
          } else {
            imageHolder = OnlineImage(
              imageUrl: books[0]["thumbnail"] ??
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/A_dictionary_of_the_Book_of_Mormon.pdf/page170-739px-A_dictionary_of_the_Book_of_Mormon.pdf.jpg",
              height: MediaQuery.of(context).size.height / 4,
            );
          }
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  //contentPadding: EdgeInsets.all(22.0),
                  title: Text("Libro encontrado"),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Se encontró el libro con el nombre \n',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '${books[0]["title"]}',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'por: ',
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${books[0]["authors"].join(', ')}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: _blueColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          child: imageHolder,
                        ),
                        Text('\n¿Es este su libro?',
                            style: TextStyle(
                                fontSize: 16.0, fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                        cameraController = new MobileScannerController();
                        BlocProvider.of<BookIsbnBloc>(context)
                            .add(ClearBookDetailsEvent());
                      },
                      child: Text("No lo es",
                          style: TextStyle(color: _greenColor)),
                    ),
                    TextButton(
                      onPressed: () async {
                        String phoneNumber = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(UserAuthRepository
                                .userInstance?.currentUser!.uid)
                            .get()
                            .then((value) => value.data()!['phoneNumber']);
                        String zipCode = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(UserAuthRepository
                                .userInstance?.currentUser!.uid)
                            .get()
                            .then((value) => value.data()!['zipCode']);
                        Navigator.popUntil(context, (route) {
                          return route.settings.name ==
                              LibglossRoutes.HOME_USED;
                        });
                        Navigator.pushNamed(
                          context,
                          LibglossRoutes.USED_BOOK_ADD,
                          arguments: {
                            "title": books[0]["title"],
                            "authors": books[0]["authors"],
                            "thumbnail": books[0]["thumbnail"],
                            "vendedor": UserAuthRepository
                                .userInstance?.currentUser!.displayName,
                            "isbn": books[0]["isbn"],
                            "precio": null,
                            "localizacion": zipCode,
                            "contacto": phoneNumber,
                          },
                        );
                      },
                      child: Text("Sí lo es",
                          style: TextStyle(color: _greenColor)),
                    ),
                  ],
                );
              });
        }
      },
      builder: (context, state) {
        if (state is BookIsbnInitial || state is BookIsbnLoaded) {
          return _buildScanner(context);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
