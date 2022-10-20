import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

class ColorSelector {
  // Colors New
  static const PRIMARY_BLUE = Color.fromRGBO(199, 246, 255, 1);
  static const SECONDARY_BLUE = Color.fromRGBO(54, 179, 201, 1);
  static const TERTIARY_BLUE = Color.fromRGBO(16, 112, 130, 1);
  
  // Colors Used
  static const PRIMARY_GREEN = Color.fromRGBO(211, 241, 173, 1);
  static const SECONDARY_GREEN = Color.fromRGBO(118, 174, 46, 1);
  static const TERTIARY_GREEN = Color.fromRGBO(78, 120, 25, 1);
  
  // Colors Tracker
  static const PRIMARY_PURPLE = Color.fromRGBO(244, 210, 255, 1);
  static const SECONDARY_PURPLE = Color.fromRGBO(215, 132, 243, 1);
  static const TERTIARY_PURPLE = Color.fromRGBO(151, 7, 199, 1);
  
  // Colors Options
  static const PRIMARY_ORANGE = Color.fromRGBO(248, 187, 176, 1);
  static const SECONDARY_ORANGE = Color.fromRGBO(245, 128, 107, 1);
  static const TERTIARY_ORANGE = Color.fromRGBO(251, 236, 233, 1);
  
  // Extra Colors
  static const RED = Color.fromRGBO(130, 48, 16, 1);
  static const BLACK = Color.fromRGBO(0, 0, 0, 1);
  static const GREY = Color.fromRGBO(36, 36, 36, 1);

  static Color getPrimary (currentRoute){
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

  static Color getSecondary (currentRoute){
    switch (currentRoute) {
      case LibglossRoutes.HOME:
        return SECONDARY_BLUE;
      case LibglossRoutes.HOME_USED:
        return SECONDARY_GREEN;
      case LibglossRoutes.BOOK_TRACKER:
        return SECONDARY_PURPLE;
      case LibglossRoutes.OPTIONS:
        return SECONDARY_ORANGE;
      default:
        return SECONDARY_BLUE;
    }
  }

  static Color getTertiary (currentRoute){
    switch (currentRoute) {
      case LibglossRoutes.HOME:
        return TERTIARY_BLUE;
      case LibglossRoutes.HOME_USED:
        return TERTIARY_GREEN;
      case LibglossRoutes.BOOK_TRACKER:
        return TERTIARY_ORANGE;
      case LibglossRoutes.OPTIONS:
        return TERTIARY_ORANGE;
      default:
        return TERTIARY_BLUE;
    }
  }

  static Color getRed (){
    return RED;
  }
  static Color getBlack (){
    return BLACK;
  }
  static Color getGrey (){
    return GREY;
  }

  static AssetImage getBackground (currentRoute){
    if (currentRoute == LibglossRoutes.OPTIONS){
      return AssetImage('assets/images/background_o.png');
    }
    else {
      return AssetImage('assets/images/background_p.png');
    }
  }
}