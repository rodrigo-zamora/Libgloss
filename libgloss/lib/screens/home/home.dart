import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _MainPageState();
}

class _MainPageState extends State<Home> {
  Color _appBarColor = Color.fromRGBO(199, 246, 255, 1);
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: _appBarColor,
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarColor,
        toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 325,
                        height: 30,
                        child: TextField(
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical(y: 1),
                          controller: _textFieldController,
                          decoration: InputDecoration(
                            hintText: "Buscar en Libgloss",
                            hintStyle: TextStyle(
                              fontSize: 15,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 32,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.topLeft,
                        color: Color.fromRGBO(124, 196, 209, 1),
                        child: Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Image.asset(
                            'assets/onlybunny.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(),
    );
  }
}
