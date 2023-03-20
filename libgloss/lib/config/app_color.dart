// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';

class AppColor {
  static const primaryColor = Color.fromRGBO(242, 242, 242, 1);

  // Colors New
  static const primaryBlue = Color.fromRGBO(199, 246, 255, 1); //#C7F6FF
  static const secondaryBlue = Color.fromRGBO(54, 179, 201, 1); //#36B3C9
  static const tertiaryBlue = Color.fromRGBO(16, 112, 130, 1); //#107082
  static const quaternaryBlue = Color.fromRGBO(228, 243, 245, 1);

  // Colors Used
  static const primaryGreen = Color.fromRGBO(211, 241, 173, 1); //#D3F1AD
  static const secondaryGreen = Color.fromRGBO(118, 174, 46, 1); //#76AE2E
  static const tertiaryGreen = Color.fromRGBO(78, 120, 25, 1); //#4E7819
  static const quaternaryGreen = Color.fromRGBO(199, 246, 255, 1);

  // Colors Tracker
  static const primaryPurple = Color.fromRGBO(244, 210, 255, 1); //#F4D2FF
  static const secondaryPurple = Color.fromRGBO(215, 132, 243, 1); //#D784F3
  static const tertiaryPurple = Color.fromRGBO(151, 7, 199, 1); //#9707C7
  static const quaternaryPurple = Color.fromRGBO(249, 237, 253, 1); //#F9EDFD

  // Colors Options
  static const primaryOrange = Color.fromRGBO(253, 191, 180, 1); //#FDBFB4
  static const secondaryOrange = Color.fromRGBO(245, 128, 107, 1); //#F5806B
  static const tertiaryOrange = Color.fromRGBO(210, 83, 45, 1); //#D2532D
  static const quaternaryOrange = Color.fromRGBO(251, 236, 233, 1); //#FBECF9

  // Extra Colors
  static const red = Color.fromRGBO(130, 48, 16, 1); //#823010
  static const black = Color.fromRGBO(0, 0, 0, 1); //#000000
  static const gray = Color.fromRGBO(36, 36, 36, 1); //#242424
  static const lightGray = Color.fromRGBO(235, 240, 244, 1); //#E1D9E6

  static Color getPrimary(currentRoute) {
    switch (currentRoute) {
      case Routes.usedBooks:
        return primaryGreen;
      case Routes.bookTracker:
        return primaryPurple;
      case Routes.options:
        return primaryOrange;
      default:
        return primaryBlue;
    }
  }

  static Color getSecondary(currentRoute) {
    switch (currentRoute) {
      case Routes.usedBooks:
        return secondaryGreen;
      case Routes.bookTracker:
        return secondaryPurple;
      case Routes.options:
        return secondaryOrange;
      default:
        return secondaryBlue;
    }
  }

  static Color getTertiary(currentRoute) {
    switch (currentRoute) {
      case Routes.usedBooks:
        return tertiaryGreen;
      case Routes.bookTracker:
        return tertiaryPurple;
      case Routes.options:
        return tertiaryOrange;
      default:
        return tertiaryBlue;
    }
  }

  static Color getQuaternary(currentRoute) {
    switch (currentRoute) {
      case Routes.usedBooks:
        return quaternaryGreen;
      case Routes.bookTracker:
        return quaternaryPurple;
      case Routes.options:
        return quaternaryOrange;
      default:
        return quaternaryBlue;
    }
  }
}
