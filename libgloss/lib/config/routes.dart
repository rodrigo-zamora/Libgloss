import 'package:flutter/material.dart';

import '../screens/features/book_tracker.dart';
import '../screens/new_books/home_new.dart';
import '../screens/new_books/new_book_details.dart';
import '../screens/new_books/new_book_search.dart';
import '../screens/used_books/home_used.dart';
import '../screens/used_books/used_book_details.dart';
import '../screens/used_books/used_book_seller.dart';
import '../screens/user/user_options.dart';

class LibglossRoutes {
  static const HOME = "/";
  static const SEARCH_NEW = "/search_new";
  static const HOME_USED = "/home_used";
  static const OPTIONS = "/user_options";
  static const NEW_BOOK_DETAILS = "/new_book_details";
  static const USED_BOOK_DETAILS = "/used_book_details";
  static const USED_BOOK_SELLER = "/used_book_seller";
  static const BOOK_TRACKER = "/book_tracker";

  static var CURRENT_ROUTE = HOME;

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      HOME: (context) => HomeNew(),
      SEARCH_NEW: (context) => NewBookSearch(),
      HOME_USED: (context) => HomeUsed(),
      OPTIONS: (context) => UserOptions(),
      NEW_BOOK_DETAILS: (context) => NewBookDetails(),
      USED_BOOK_DETAILS: (context) => UsedBookDetails(),
      USED_BOOK_SELLER: (context) => UsedBookSeller(),
      BOOK_TRACKER: (context) => BookTracker(),
    };
  }

  static Widget getHomeRoute() {
    return HomeNew();
  }
}
