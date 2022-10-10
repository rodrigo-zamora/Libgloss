import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

void main() {
  runApp(Libgloss());
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
            settings: settings);
      },
    );
  }
}
