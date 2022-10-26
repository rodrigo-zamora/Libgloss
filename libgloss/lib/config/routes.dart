import 'package:flutter/material.dart';

import '../screens/main/home.dart';
import '../screens/tracker/book_tracker.dart';
import '../screens/features/scanner.dart';
import '../screens/new_books/home_new.dart';
import '../screens/new_books/new_book_details.dart';
import '../screens/new_books/new_book_search.dart';
import '../screens/used_books/home_used.dart';
import '../screens/used_books/used_book_details.dart';
import '../screens/used_books/used_book_search.dart';
import '../screens/used_books/used_book_seller.dart';
import '../screens/user/user_options.dart';
import '../screens/log_in/account.dart';
import '../screens/log_in/login.dart';
import '../screens/log_in/sign_up.dart';
import '../widgets/animations/splash.dart';

class LibglossRoutes {
  static const HOME = "/";
  static const HOME_NEW = "/home_new";
  static const HOME_USED = "/home_used";
  static const SEARCH_NEW = "/search_new";
  static const OPTIONS = "/user_options";
  static const NEW_BOOK_DETAILS = "/new_book_details";
  static const USED_BOOK_DETAILS = "/used_book_details";
  static const USED_BOOK_SELLER = "/used_book_seller";
  static const BOOK_TRACKER = "/book_tracker";
  static const SEARCH_USED = "/search_used";
  static const SCANNER = "/scanner";
  static const LOGIN = "/login";
  static const SIGN_UP = "/sign_up";
  static const ACCOUNT = "/account";
  static const SPLASH = "/splash";

  static var CURRENT_ROUTE = HOME;

  static const API = "https://libgloss.herokuapp.com/api/";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      HOME: (context) => Home(),
      HOME_NEW: (context) => HomeNew(),
      SEARCH_NEW: (context) => NewBookSearch(),
      NEW_BOOK_DETAILS: (context) => NewBookDetails(),
      HOME_USED: (context) => HomeUsed(),
      SEARCH_USED: (context) => UsedBookSearch(),
      USED_BOOK_DETAILS: (context) => UsedBookDetails(),
      USED_BOOK_SELLER: (context) => UsedBookSeller(),
      BOOK_TRACKER: (context) => BookTracker(),
      OPTIONS: (context) => UserOptions(),
      SCANNER: (context) => Scanner(),
      LOGIN: (context) => LogInForm(),
      SIGN_UP: (context) => SignUp(),
      ACCOUNT: (context) => Account(),
      SPLASH: (context) => SplashScreen(),
    };
  }

  static Widget getHomeRoute() {
    return Home();
  }

  static List<Widget> getRoutesList() {
    return [
      HomeNew(),
      HomeUsed(),
      BookTracker(),
      UserOptions(),
    ];
  }
}
