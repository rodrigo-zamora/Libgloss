import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

class ColorSelector {
  // Colors New
  static const TERTIARY_BLUE = Color.fromRGBO(16, 112, 130, 1); //#107082
  static const SECONDARY_BLUE = Color.fromRGBO(54, 179, 201, 1); //#36B3C9
  static const PRIMARY_BLUE = Color.fromRGBO(199, 246, 255, 1); //#C7F6FF
  static const QUATERNARY_BLUE = Color.fromRGBO(228, 243, 245, 1);

  // Colors Used
  static const TERTIARY_GREEN = Color.fromRGBO(78, 120, 25, 1); //#4E7819
  static const SECONDARY_GREEN = Color.fromRGBO(118, 174, 46, 1); //#76AE2E
  static const PRIMARY_GREEN = Color.fromRGBO(211, 241, 173, 1); //#D3F1AD
  static const QUATERNARY_GREEN = Color.fromRGBO(199, 246, 255, 1);

  // Colors Tracker
  static const TERTIARY_PURPLE = Color.fromRGBO(151, 7, 199, 1); //#9707C7
  static const SECONDARY_PURPLE = Color.fromRGBO(215, 132, 243, 1); //#D784F3
  static const PRIMARY_PURPLE = Color.fromRGBO(244, 210, 255, 1); //#F4D2FF
  static const QUATERNARY_PURPLE = Color.fromRGBO(249, 237, 253, 1); //#F9EDFD

  // Colors Options
  static const TERTIARY_ORANGE = Color.fromRGBO(210, 83, 45, 1); //#D2532D
  static const SECONDARY_ORANGE = Color.fromRGBO(245, 128, 107, 1); //#F5806B
  static const PRIMARY_ORANGE = Color.fromRGBO(253, 191, 180, 1); //#FDBFB4
  static const QUATERNARY_ORANGE = Color.fromRGBO(251, 236, 233, 1); //#FBECF9

  // Extra Colors
  static const RED = Color.fromRGBO(130, 48, 16, 1); //#823010
  static const BLACK = Color.fromRGBO(0, 0, 0, 1); //#000000
  static const GREY = Color.fromRGBO(36, 36, 36, 1); //#242424
  static const GREYISH = Color.fromRGBO(235, 240, 244, 1); //#E1D9E6

  static Color getPrimary(currentRoute) {
    switch (currentRoute) {
      case LibglossRoutes.HOME:
        return PRIMARY_BLUE;
      case LibglossRoutes.HOME_USED:
        return PRIMARY_GREEN;
      case LibglossRoutes.BOOK_TRACKER:
        return PRIMARY_PURPLE;
      case LibglossRoutes.OPTIONS:
        return PRIMARY_ORANGE;
      default:
        return PRIMARY_BLUE;
    }
  }

  static Color getSecondary(currentRoute) {
    switch (currentRoute) {
      case "HomeNew":
      case LibglossRoutes.HOME:
        return SECONDARY_BLUE;
      case "HomeUsed":
      case LibglossRoutes.HOME_USED:
        return SECONDARY_GREEN;
      case "BookTracker":
      case LibglossRoutes.BOOK_TRACKER:
        return SECONDARY_PURPLE;
      case "UserOptions":
      case "LogInForm":
      case LibglossRoutes.OPTIONS:
        return SECONDARY_ORANGE;
      default:
        return SECONDARY_BLUE;
    }
  }

  static Color getTertiary(currentRoute) {
    switch (currentRoute) {
      case LibglossRoutes.HOME:
        return TERTIARY_BLUE;
      case LibglossRoutes.HOME_USED:
        return TERTIARY_GREEN;
      case LibglossRoutes.BOOK_TRACKER:
        return TERTIARY_PURPLE;
      case LibglossRoutes.OPTIONS:
        return TERTIARY_ORANGE;
      default:
        return TERTIARY_BLUE;
    }
  }

  static Color getQuaternary(currentRoute) {
    switch (currentRoute) {
      case LibglossRoutes.HOME:
        return QUATERNARY_BLUE;
      case LibglossRoutes.HOME_USED:
        return QUATERNARY_GREEN;
      case LibglossRoutes.BOOK_TRACKER:
        return QUATERNARY_PURPLE;
      case LibglossRoutes.OPTIONS:
        return QUATERNARY_ORANGE;
      default:
        return QUATERNARY_BLUE;
    }
  }

  static Color getRed() {
    return RED;
  }

  static Color getBlack() {
    return BLACK;
  }

  static Color getGrey() {
    return GREY;
  }

  static Color getGreyish() {
    return GREYISH;
  }

  static AssetImage getBackground(currentRoute) {
    if (currentRoute == LibglossRoutes.OPTIONS) {
      return AssetImage('assets/images/login/background_o.png');
    } else {
      return AssetImage('assets/images/login/background_p.png');
    }
  }
}
