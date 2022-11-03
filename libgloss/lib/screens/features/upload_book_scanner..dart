import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/books/bloc/books_bloc.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';
import 'package:libgloss/config/colors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../config/routes.dart';
import '../../widgets/shared/search_appbar.dart';

class UploadBookScanner extends StatelessWidget {
  UploadBookScanner({super.key});

  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.HOME_USED);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.HOME_USED);
  final MobileScannerController cameraController = MobileScannerController();

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
        body: _buildScanner(context));
  }

  MobileScanner _buildScanner(BuildContext context) {
    return MobileScanner(
        allowDuplicates: false,
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
            final String code = barcode.rawValue!;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Códiog ISBN detectado: $code'),
                ),
              );
            BlocProvider.of<SearchBloc>(context).add(SearchBoookEvent(
              query: '',
              filters: {
                'isbn': code,
              },
            ));
            _getBookDetails(context);
            Navigator.pop(context);
          }
        });
  }

  BlocConsumer<SearchBloc, SearchState> _getBookDetails(BuildContext context) {
    print('getBookDetails');
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        print('listener');
        if (state is SearchError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('No se ha podido leer el código'),
              ),
            );
        } else if (state is BookLoaded) {
          print("HEREE");
          print(state.toString());
          _onSearch(context);
        }
      },
      builder: (context, state) {
        print('builder');
        return Container();
      },
    );
  }

  void _onSearch(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: EdgeInsets.all(22.0),
          title: Text('Código ISBN detectado'),
          content: Row(
            children: [
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      // TODO: Modify the text to show the ISBN code and book details
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'El libro'),
                        TextSpan(
                            text: 'código de barras',
                            style:
                                TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                ' del mismo\nSerá redirigido al scan de cámara '),
                        TextSpan(
                            text: '¿Desea continuar?',
                            style:
                                TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // TODO: Agregar imagen del libro
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
