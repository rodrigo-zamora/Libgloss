import 'package:flutter/material.dart';
import 'package:libgloss/widgets/shared/online_image.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

class UsedBookAdd extends StatefulWidget {
  UsedBookAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<UsedBookAdd> createState() => _UsedBookAddState();
}

class _UsedBookAddState extends State<UsedBookAdd> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.HOME_USED);
  final Color _secondaryColor = ColorSelector.getSecondary(LibglossRoutes.HOME_USED);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);
  final Color _greenColor = ColorSelector.getTertiary(LibglossRoutes.HOME_USED);
  final Color _defaultColor = ColorSelector.getBlack();

  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments;
    _args as Map<String, dynamic>;
    return Scaffold(
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
            _text("${_args["authors"].join(', ')}", _blueColor, 15.0, FontWeight.normal,
                TextAlign.center),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _text("vendido por:  ", _defaultColor, 14.0, FontWeight.normal,
                    TextAlign.center),
                _text("${_args["vendedor"]}", _greenColor, 14.0,
                    FontWeight.normal, TextAlign.center),
              ],
            ),
            SizedBox(height: 8),
            _text("${_args["isbn"]}", _defaultColor, 15.0, FontWeight.normal,
                TextAlign.center),
            SizedBox(height: 20.0),
            _image(_args["thumbnail"]),
            SizedBox(height: 20.0),
            _text("Información", _defaultColor, 15.0, FontWeight.normal,
                TextAlign.center),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Divider(
                color: _defaultColor,
                thickness: 0.5,
              ),
            ),
            Container(
              child: Table(
                children: [
                  _row("precio:", "\$${_args["precio"]}"),
                  _row("localización:", "${_args["localizacion"]}"),
                  _row("contacto:", "${_args["contacto"]}"),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            _buttonSeller(context, _args),
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

  Container _image(String? image) {
    if (image == null) {
      return Container(
        child: Image.asset(
          'assets/images/special/not_found_e.png',
        ),
      );
    }
    else {
      return Container(
        height: (MediaQuery.of(context).size.height / 2.5),
        child: OnlineImage(
          imageUrl: image,
          height: 100,
        )
      );
    }
  }

  TableRow _row(String title, String value) {
    return TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: _text(
              title, _defaultColor, 15.0, FontWeight.normal, TextAlign.right),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: _text(
              value, _defaultColor, 15.0, FontWeight.normal, TextAlign.left),
        ),
      ),
    ]);
  }

  ElevatedButton _buttonSeller(
      BuildContext context, Map<String, dynamic> _args) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _secondaryColor,
        foregroundColor: _primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      ),
      onPressed: () {
        // TODO: add book to firebase and go to home
        print("Guardar libro");
      },
      child: _text("Guardar libro", _defaultColor, 15.0, FontWeight.normal,
          TextAlign.center),
    );
  }
}
