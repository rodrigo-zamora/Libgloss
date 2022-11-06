import 'package:flutter/material.dart';

import '../screens/features/upload_book_scanner..dart';
import '../screens/main/home.dart';
import '../screens/tracker/book_tracker.dart';
import '../screens/features/scanner.dart';
import '../screens/new_books/home_new.dart';
import '../screens/new_books/new_book_details.dart';
import '../screens/used_books/used_book_add.dart';
import '../screens/new_books/new_book_search.dart';
import '../screens/used_books/home_used.dart';
import '../screens/used_books/used_book_details.dart';
import '../screens/used_books/used_book_search.dart';
import '../screens/used_books/used_book_seller.dart';
import '../screens/user/user_options.dart';
import '../screens/log_in/account.dart';
import '../screens/log_in/login.dart';
import '../screens/log_in/sign_up.dart';
import '../screens/features/web_view.dart';
import '../widgets/animations/splash.dart';

class LibglossRoutes {
  static const HOME = "/";
  // New books
  static const HOME_NEW = "/home_new";
  static const SEARCH_NEW = "/search_new";
  static const NEW_BOOK_DETAILS = "/new_book_details";
  // Used books
  static const HOME_USED = "/home_used";
  static const SEARCH_USED = "/search_used";
  static const USED_BOOK_DETAILS = "/used_book_details";
  static const USED_BOOK_ADD = "/used_book_add"; // this is a maybe
  static const USED_BOOK_SELLER = "/used_book_seller";
  // Tracker
  static const BOOK_TRACKER = "/book_tracker";
  // User
  static const OPTIONS = "/user_options";
  // Scanner
  static const SCANNER = "/scanner";
  static const USED_BOOK_SCANNER = "/used_book_scanner";
  // Log in
  static const LOGIN = "/login";
  static const SIGN_UP = "/sign_up";
  static const ACCOUNT = "/account";
  // Extras
  static const SPLASH = "/splash";
  static const WEB_VIEW = "/web_view";

  static var CURRENT_ROUTE = HOME;

  static const API = "https://libgloss.herokuapp.com/api/";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      HOME: (context) => Home(),
      // New Books
      HOME_NEW: (context) => HomeNew(),
      SEARCH_NEW: (context) => NewBookSearch(),
      NEW_BOOK_DETAILS: (context) => NewBookDetails(),
      // Used Books
      HOME_USED: (context) => HomeUsed(),
      SEARCH_USED: (context) => UsedBookSearch(),
      USED_BOOK_DETAILS: (context) => UsedBookDetails(),
      USED_BOOK_ADD: (context) => UsedBookAdd(), // this is a maybe
      USED_BOOK_SELLER: (context) => UsedBookSeller(),
      // Tracker 
      BOOK_TRACKER: (context) => BookTracker(),
      // User
      OPTIONS: (context) => UserOptions(),
      // Scanner
      SCANNER: (context) => Scanner(),
      USED_BOOK_SCANNER: (context) => UploadBookScanner(),
      // Log In
      LOGIN: (context) => LogInForm(),
      SIGN_UP: (context) => SignUp(),
      ACCOUNT: (context) => Account(),
      // Extras
      SPLASH: (context) => SplashScreen(),
      WEB_VIEW: (context) => WebViewPage(),
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
      UserOptions(),//Account(), UserOptions()
    ];
  }
}
