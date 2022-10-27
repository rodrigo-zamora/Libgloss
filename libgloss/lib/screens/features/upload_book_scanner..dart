import 'package:flutter/material.dart';
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
            // TODO: Implementar la lógica de búsqueda del libro
          }
        });
  }
}
