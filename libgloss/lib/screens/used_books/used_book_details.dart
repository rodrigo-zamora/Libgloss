import 'package:flutter/material.dart';

import '../../config/routes.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/search_appbar.dart';
import '../../widgets/side_menu.dart';

class UsedBookDetails extends StatefulWidget {
  String? title;
  String? author;
  String? image;
  String? vendedor;
  String? isbn;
  String? precio;
  String? localizacion;
  String? contacto;

  UsedBookDetails({
    required this.title,
    required this.author,
    required this.image,
    required this.vendedor,
    required this.isbn,
    required this.precio,
    required this.localizacion,
    required this.contacto,
    Key? key,
  }) : super(key: key);

  @override
  State<UsedBookDetails> createState() => _UsedBookDetailsState();
}

class _UsedBookDetailsState extends State<UsedBookDetails> {
  final Color _primaryColor = Color.fromRGBO(211, 241, 173, 1);
  final Color _secondaryColor = Color.fromRGBO(118, 174, 46, 1);
  final Color _blueColor = Color.fromRGBO(16, 112, 130, 1);
  final Color _greenColor = Color.fromRGBO(78, 120, 25, 1);
  final Color _defaultColor = Color.fromRGBO(0, 0, 0, 1);
  
  TextEditingController _textFieldController = TextEditingController();

  late var _libro = {
    "title": widget.title,
    "author": widget.author,
    "image": widget.image,
    "vendedor": widget.vendedor,
    "isbn": widget.isbn,
    "precio": widget.precio,
    "localizacion": widget.localizacion,
    "contacto": widget.contacto,
  };

  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _main(context),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.HOME_USED, iconColor: _secondaryColor),
    );
  }

  SingleChildScrollView _main(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _text("${_libro["title"]}", _defaultColor, 20.0, FontWeight.bold, TextAlign.center),
            SizedBox(height: 5),
            _text("${_libro["author"]}", _blueColor, 15.0, FontWeight.normal, TextAlign.center),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _text("vendido por:  ", _defaultColor, 14.0, FontWeight.normal, TextAlign.center),
                _text("${_libro["vendedor"]}", _greenColor, 14.0, FontWeight.normal, TextAlign.center),
              ],
            ),
            SizedBox(height: 8),
            _text("${_libro["isbn"]}", _defaultColor, 15.0, FontWeight.normal, TextAlign.center),
            SizedBox(height: 20.0),
            _image(_libro["image"]!),
            SizedBox(height: 20.0),
            _text("Información", _defaultColor, 15.0, FontWeight.normal, TextAlign.center),
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
                  _row("precio:", "\$${_libro["precio"]}"),
                  _row("localización:", "${_libro["localizacion"]}"),
                  _row("contacto:", "${_libro["contacto"]}"),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _secondaryColor,
                foregroundColor: _primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              ),
              onPressed: () {
                Navigator.pushNamed(context, LibglossRoutes.USED_BOOK_SELLER);
              }, 
              child: _text("Contactar Vendedor", _defaultColor, 15.0, FontWeight.normal, TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }

  Text _text(String text, Color color, double size, FontWeight weight, TextAlign align) {
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
      child: Image.network(
        image,  
        fit: BoxFit.fill,
      )
    );
  }
  
  TableRow _row (String title, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: _text(title, _defaultColor, 15.0, FontWeight.normal, TextAlign.right),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: _text(value, _defaultColor, 15.0, FontWeight.normal, TextAlign.left),
          ),
        ),
      ]
    );
  }
  
}
