import 'package:flutter/material.dart';

class AppFunctions {
  static String getSortingType(int sortType) {
    if (sortType == 0) {
      return 'sort by ATTRIBUTE';
    } else if (sortType == 1) {
      return "sort by ATTACK RANGE";
    } else if (sortType == 2) {
      return "sort by GENDER";
    } else {
      return "sort by DIFFICULTY";
    }
  }

  static IconData getYearIcon(
      {required String selectedHeroReleaseYear,
      required String guessHeroReleaseYear}) {
    IconData iconData = Icons.add;
    int a = int.parse(selectedHeroReleaseYear);
    int b = int.parse(guessHeroReleaseYear);
    if (a > b) {
      iconData = Icons.arrow_upward;
    } else if (a < b) {
      iconData = Icons.arrow_downward;
    }
    return iconData;
  }

  static Color getPrimaryAttributeColor(String attribute) {
    if (attribute.toUpperCase() == "AGILITY") {
      return Colors.green;
    } else if (attribute.toUpperCase() == "STRENGTH") {
      return Colors.red;
    } else if (attribute.toUpperCase() == "INTELLIGENCE") {
      return Colors.blue;
    } else {
      return Colors.purple;
    }
  }
}
