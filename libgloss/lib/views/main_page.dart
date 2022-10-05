import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _textFieldController = TextEditingController();

  ThemeData blueTheme = ThemeData(
    appBarTheme: AppBarTheme(
        color: Color.fromRGBO(199, 246, 255, 1),
        iconTheme: IconThemeData(color: Color.fromRGBO(199, 246, 255, 1))),
    backgroundColor: Color.fromRGBO(199, 246, 255, 1),
    primaryColor: Color.fromRGBO(199, 246, 255, 1),
    textTheme: TextTheme(
      subtitle2: TextStyle(
        color: Color.fromRGBO(16, 112, 130, 1),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110, //set your height
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(199, 246, 255, 1), // set your color
                child: Container(
                  height: 70,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {}
                      ),
                      SizedBox(
                        width: 300,
                        height: 35,
                        child: TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(
                            //hintText: "Buscar en Libgloss",
                            labelText: "Buscar en Libgloss",
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ),
                      ),
                      
                    ],
                  ),// set your search bar setting
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topLeft,
                color: Color.fromRGBO(124, 196, 209, 1), // set your color
                child: Image.asset(
                  'assets/onlybunny.png',
                ),
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}