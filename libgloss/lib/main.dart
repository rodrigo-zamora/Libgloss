import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/animations/slide_route.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'config/blocs.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  // Run the initialization splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Run the app
  runApp(BlocSettings.getBlocProviders(Libgloss()));
  FlutterNativeSplash.remove();
}

class Libgloss extends StatelessWidget {
  const Libgloss({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LibglossRoutes.getRoute(LibglossRoutes.HOME),
      onGenerateRoute: (settings) {
        return SlideRoute(
          page: LibglossRoutes.getRoutes()[settings.name]!(context),
          settings: settings,
        );
      },
    );
  }
}
