import 'package:flutter/material.dart';
import 'package:libgloss/widgets/shared/online_image.dart';

import '../../config/routes.dart';
import '../../widgets/shared/bottom_navigation.dart';
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
  final Color _primaryColor = Color.fromRGBO(199, 246, 255, 1);
  final Color _secondaryColor = Color.fromRGBO(54, 179, 201, 1);
  final Color _blueColor = Color.fromRGBO(16, 112, 130, 1);
  final Color _redColor = Color.fromRGBO(130, 48, 16, 1);
  final Color _defaultColor = Color.fromRGBO(0, 0, 0, 1);

  TextEditingController _textFieldController = TextEditingController();

  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments;
    _args as Map<String, dynamic>;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
            primaryColor: _primaryColor,
            secondaryColor: _secondaryColor,
            textFieldController: _textFieldController,
            showMenuButton: false,
            showCameraButton: false),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: _main(context, _args),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.HOME, iconColor: _secondaryColor),
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
            _text("${_args["author"]}", _blueColor, 15.0, FontWeight.normal,
                TextAlign.center),
            SizedBox(height: 5),
            _text("${_args["isbn"]}", _defaultColor, 15.0, FontWeight.normal,
                TextAlign.center),
            SizedBox(height: 20.0),
            _image(_args["image"]! as String),
            SizedBox(height: 20.0),
            Container(
              child: Table(
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 0.5),
                children: [
                  _row("Amazon", _blueColor, "\$${_args["amazon"]}"),
                  _row("Gonvill", _blueColor, "\$${_args["gonvill"]}"),
                  _row("Gandhi", _redColor, "\$${_args["gandhi"]}"),
                  _row("El Sótano", _redColor, "\$${_args["sotano"]}"),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, LibglossRoutes.BOOK_TRACKER);
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
                Navigator.pushNamed(context, LibglossRoutes.BOOK_TRACKER);
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
          width: 100,
        ));
  }

  TableRow _row(String title, Color color, String value) {
    return TableRow(children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: _text(title, color, 15.0, FontWeight.bold, TextAlign.center),
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
  }
}
