import 'package:flutter/material.dart';

import 'views/configuraciones.dart';
import 'views/detalles_nuevos.dart';
import 'views/detalles_usados.dart';
import 'views/main_page.dart';
import 'views/seguimientos.dart';
import 'views/vendedor_usados.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true, //<-- SEE HERE
          fillColor: Colors.white, //<-- SEE HERE
        ),
      ),
      home: MainPage(
      ),
      routes: {
        "/main_pafe": (context) => MainPage(
        ),
        "/detalles_nuevos": (context) => DetallesNuevos(
        ),
        "/detalles_usados": (context) => DetallesUsados(
        ),
        "/vendedor_usados": (context) => VendedorUsados(
        ),
        "/seguimientos": (context) => Seguimientos(
        ),
        "/configuraciones": (context) => Configuraciones(
        )
      },
    );
  }
}
