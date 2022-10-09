import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import 'screens/user_options.dart';
import 'screens/book_search/new_book_details.dart';
import 'screens/book_search/used_book_details.dart';
import 'screens/home/home.dart';
import 'screens/features/book_tracker.dart';
import 'screens/used_book_seller.dart';

void main() {
  runApp(Libgloss());
}

class Libgloss extends StatelessWidget {
  const Libgloss({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: _registerRoutes(),
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return {
      LibglossRoutes.HOME: (context) => Home(),
      LibglossRoutes.OPTIONS: (context) => UserOptions(),
      LibglossRoutes.NEW_BOOK_DETAILS: (context) => NewBookDetails(),
      LibglossRoutes.USED_BOOK_DETAILS: (context) => UsedBookDetails(),
      LibglossRoutes.USED_BOOK_SELLER: (context) => UsedBookSeller(),
      LibglossRoutes.BOOK_TRACKER: (context) => BookTracker(),
    };
  }
}
