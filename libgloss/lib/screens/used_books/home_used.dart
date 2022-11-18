import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libgloss/config/colors.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';
import 'package:libgloss/widgets/shared/side_menu.dart';

import '../../widgets/shared/online_image.dart';
import '../../widgets/shared/search_appbar.dart';
//import 'pop_up.dart';

class HomeUsed extends StatefulWidget {
  HomeUsed({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeUsed> createState() => _HomeUsedState();
}

class _HomeUsedState extends State<HomeUsed> {
  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.HOME_USED);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.HOME_USED);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);
  final Color _greenColor = ColorSelector.getTertiary(LibglossRoutes.HOME_USED);

  final List<Map<String, dynamic>> _listElements = [
    {
      "title": "Maze Runner",
      "authors": ["James Dashner"],
      "thumbnail": "https://m.media-amazon.com/images/I/81+462s7qWL.jpg",
      "vendedor": "Ernesto Contreras",
      "isbn": "978-6077547327",
      "precio": 100,
      "localizacion": "Guadalajara, Jalisco",
      "contacto": "1111111111",
    },
    {
      "title": "Bajo la Misma Estrella",
      "authors": ["John Green"],
      "thumbnail":
          "https://http2.mlstatic.com/D_NQ_NP_825774-MLM49787856481_042022-V.jpg",
      "vendedor": "Lupita Gómez",
      "isbn": "978-6073114233",
      "precio": 95,
      "localizacion": "Zapopan, Jalisco",
      "contacto": "2222222222",
    },
    {
      "title": "El niño de la pijama de rayas",
      "authors": ["John Boyne"],
      "thumbnail":
          "https://images.cdn3.buscalibre.com/fit-in/360x360/2d/84/2d845ff0cd78bb3fb398f879e3758df0.jpg",
      "vendedor": "Julian Vico",
      "isbn": "978-6073193320",
      "precio": 70,
      "localizacion": "Tlajomulco, Jalisco",
      "contacto": "3333333333",
    },
    {
      "title": "El Principito",
      "authors": ["Antoine de Saint-Exupéry"],
      "thumbnail":
          "https://madreditorial.com/wp-content/uploads/2021/07/9788417430993-ok.png",
      "vendedor": "Maria Lucia Perera",
      "isbn": "978-6070730535",
      "precio": 50,
      "localizacion": "Tlaquepaque, Jalisco",
      "contacto": "4444444444",
    },
    {
      "title": "1984",
      "authors": ["George Orwell"],
      "thumbnail":
          "https://images.cdn2.buscalibre.com/fit-in/360x360/3a/2c/3a2c227d11a1026b4aa3d45d33bad4f6.jpg",
      "vendedor": "Roman Dominguez",
      "isbn": "978-6073116336",
      "precio": 80,
      "localizacion": "El Salto, Jalisco",
      "contacto": "5555555555",
    },
    {
      "title": "El señor de las moscas",
      "authors": ["William Golding"],
      "thumbnail":
          "https://http2.mlstatic.com/D_NQ_NP_906011-MLM32761111866_112019-O.jpg",
      "vendedor": "Maria Asuncion Perez",
      "isbn": "978-8420674179",
      "precio": 120,
      "localizacion": "Tonalá, Jalisco",
      "contacto": "6666666666",
    },
  ];

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(UserAuthRepository().getuid()).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic>? data =
                snapshot.data!.data() as Map<String, dynamic>?;
            return _buildSellingPage(data);
          }
        }

        return _loadingPage();
      },
    );
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

  Widget _buildSellingPage(Map<String, dynamic>? data) {
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
      body: _add(context, data),
    );
  }

  SizedBox _add(context, Map<String, dynamic>? data) {
    return SizedBox(
        child: Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
      _found(context),
      data != null ? _button(data['isSeller']) : Container(),
    ]));
  }

  Widget _button(bool isSeller) {
    if (UserAuthRepository().isAuthenticated() && isSeller) {
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
      //color: Colors.teal[100],
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
              if (kDebugMode)
                print(
                    "[HomeUsed] Moving to details of ${_listElements[index]["title"]}");
              Navigator.pushNamed(
                context,
                LibglossRoutes.USED_BOOK_DETAILS,
                arguments: _listElements[index],
              );
            },
            child: Container(
              height: (MediaQuery.of(context).size.height / 5.5),
              child: OnlineImage(
                imageUrl: "${_listElements[index]["thumbnail"]}",
                height: 100,
              ),
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
            "${_listElements[index]["author"]}",
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
            "${_listElements[index]["vendedor"]}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _greenColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  void _openCamera() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            contentPadding: EdgeInsets.all(22.0),
            title: Text("Abrir cámara"),
            content: //Text("Para subir un libro se necesita escanear el código de barras del mismo\nSerá redirigido al scan de cámara ¿Quieres continuar?"),
                RichText(
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
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
                  Navigator.pop(context, 'OK');
                  // TODO: Add window to enter the book manually
                },
                child: Text("Ingresar código manualmente",
                    style: TextStyle(color: _greenColor)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  Navigator.pushNamed(
                    context,
                    LibglossRoutes.USED_BOOK_SCANNER,
                  );
                },
                child: Text("Continuar", style: TextStyle(color: _greenColor)),
              ),
            ],
          );
        });
  }
}
