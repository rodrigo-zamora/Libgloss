import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/bookISBN/bloc/book_isbn_bloc.dart';
import 'package:libgloss/config/colors.dart';
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
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        } else if (state is BookIsbnLoaded) {
          var books = state.bookDetails;
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
                          child: OnlineImage(
                            imageUrl: books[0]["thumbnail"],
                            height: MediaQuery.of(context).size.height / 4,
                          ),
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
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                        // TODO: Add book to user's books
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
        return _buildScanner(context);
      },
    );
  }
}
