import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';

class Scanner extends StatelessWidget {
  Scanner({
    Key? key,
  }) : super(key: key);

  final Color _primaryColor = AppColor.getPrimary(Routes.newBooks);
  final Color _secondaryColor = AppColor.getSecondary(Routes.newBooks);
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
            title: 'Escanea un libro',
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
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              Routes.searchNewBooks,
            );
            Map<String, dynamic> filters = {
              'isbn': code,
            };
            BlocProvider.of<SearchBloc>(context).add(SearchBoookEvent(
              query: '',
              filters: filters,
            ));
          }
        });
  }
}
