import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

import 'screens/user/user_options.dart';
import 'screens/new_books/new_book_details.dart';
import 'screens/used_books/used_book_details.dart';
import 'screens/new_books/home_new.dart';
import 'screens/features/book_tracker.dart';
import 'screens/used_books/used_book_seller.dart';
import 'screens/used_books/home_used.dart';


void main() {
  runApp(Libgloss());
}

class Libgloss extends StatelessWidget {
  const Libgloss({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeNew(),
      routes: _registerRoutes(),
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return {
      LibglossRoutes.HOME: (context) => HomeNew(),
      LibglossRoutes.HOME_USED: (context) => HomeUsed(),
      LibglossRoutes.OPTIONS: (context) => UserOptions(),
      LibglossRoutes.NEW_BOOK_DETAILS: (context) => NewBookDetails(),
      LibglossRoutes.USED_BOOK_DETAILS: (context) => UsedBookDetails(),
      LibglossRoutes.USED_BOOK_SELLER: (context) => UsedBookSeller(),
      LibglossRoutes.BOOK_TRACKER: (context) => BookTracker(),
    };
  }
}
