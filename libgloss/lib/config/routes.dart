import 'package:flutter/material.dart';
import 'package:libgloss/screens/features/scanner.dart';
import 'package:libgloss/screens/features/upload_book_scanner..dart';
import 'package:libgloss/screens/features/web_view.dart';
import 'package:libgloss/screens/log_in/login.dart';
import 'package:libgloss/screens/main/home.dart';
import 'package:libgloss/screens/new_books/home_new.dart';
import 'package:libgloss/screens/new_books/new_book_details.dart';
import 'package:libgloss/screens/new_books/new_book_search.dart';
import 'package:libgloss/screens/tracker/book_tracker.dart';
import 'package:libgloss/screens/used_books/home_used.dart';
import 'package:libgloss/screens/used_books/used_book_add.dart';
import 'package:libgloss/screens/used_books/used_book_details.dart';
import 'package:libgloss/screens/used_books/used_book_search.dart';
import 'package:libgloss/screens/used_books/used_book_seller.dart';
import 'package:libgloss/screens/user/my_account.dart';
import 'package:libgloss/screens/user/my_books.dart';
import 'package:libgloss/screens/user/notifications_page.dart';
import 'package:libgloss/screens/user/user_options.dart';
import 'package:libgloss/widgets/animations/splash.dart';

class Routes {
  static const api = "https://libgloss.herokuapp.com/api/";

  /* Routes definitions */

  static const home = "/";

  // New books
  static const newBooks = "/home_new";
  static const searchNewBooks = "/search_new";
  static const newBookDetails = "/new_book_details";

  // Used books
  static const usedBooks = "/home_used";
  static const searchUsedBooks = "/search_used";
  static const usedBookDetails = "/used_book_details";
  static const createUsedBook = "/used_book_add";
  static const usedBookSellerDetails = "/used_book_seller";

  // Tracker
  static const bookTracker = "/book_tracker";

  // User
  static const options = "/user_options";
  static const notifications = "/notifications";
  static const myBooks = "/my_books";
  static const myAccount = "/account";

  // Scanner
  static const newBooksScanner = "/scanner";
  static const usedBookScanner = "/used_book_scanner";

  // Log in
  static const login = "/login";
  static const signUp = "/sign_up";

  // Extras
  static const splashScreen = "/splash";
  static const webViewScreen = "/web_view";

  static var currentRoute = Routes.home;

  static final _routes = {
    home: (context) => Home(),

    // New Books
    newBooks: (context) => HomeNew(),
    searchNewBooks: (context) => NewBookSearch(),
    newBookDetails: (context) => NewBookDetails(),

    // Used Books
    usedBooks: (context) => HomeUsed(),
    searchUsedBooks: (context) => UsedBookSearch(),
    usedBookDetails: (context) => UsedBookDetails(),
    createUsedBook: (context) => UsedBookAdd(),
    usedBookSellerDetails: (context) => UsedBookSeller(),

    // Tracker
    bookTracker: (context) => BookTracker(),

    // User
    options: (context) => UserOptions(),
    notifications: (context) => ConfigurationPage(),
    myBooks: (context) => MyBooks(),
    myAccount: (context) => Account(),

    // Scanner
    newBooksScanner: (context) => Scanner(),
    usedBookScanner: (context) => UploadBookScanner(),

    // Log In
    login: (context) => LogInForm(),

    // Extras
    splashScreen: (context) => SplashScreen(),
    webViewScreen: (context) => WebViewPage(),
  };

  Map<dynamic, Widget Function(dynamic context)> getRoutes() {
    return _routes;
  }

  static Widget getRoute(String route) {
    return _routes[route]!(null);
  }
}
