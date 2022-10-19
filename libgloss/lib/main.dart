import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/animations/slide_route.dart';

import 'config/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  runApp(Bloc.getBlocProviders(Libgloss()));
}

class Libgloss extends StatelessWidget {
  const Libgloss({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LibglossRoutes.getHomeRoute(),
      onGenerateRoute: (settings) {
        return SlideRoute(
          page: LibglossRoutes.getRoutes()[settings.name]!(context),
          settings: settings,
        );
      },
    );
  }
}
