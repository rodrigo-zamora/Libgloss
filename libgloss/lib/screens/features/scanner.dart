import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../widgets/shared/search_appbar.dart';

class Scanner extends StatelessWidget {
  Scanner({
    Key? key,
  }) : super(key: key);

  final Color _primaryColor = Color.fromRGBO(199, 246, 255, 1);
  final Color _secondaryColor = Color.fromRGBO(54, 179, 201, 1);
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
                  content: Text('No barcode detected'),
                ),
              );
          } else {
            final String code = barcode.rawValue!;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Barcode detected: $code'),
                ),
              );
          }
        });
  }
}
