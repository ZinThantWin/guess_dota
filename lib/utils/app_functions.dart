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
      {required selectedHeroReleaseYear, required int guessHeroReleaseYear}) {
    IconData iconData = Icons.add;
    if (selectedHeroReleaseYear > guessHeroReleaseYear) {
      iconData = Icons.arrow_upward;
    } else if (selectedHeroReleaseYear < guessHeroReleaseYear) {
      iconData = Icons.arrow_downward;
    }
    return iconData;
  }

  static String getAttackType(int attackType) {
    if (attackType == 1) {
      return 'Melee';
    } else if (attackType == 2) {
      return "Range";
    } else {
      return "Both";
    }
  }

  static String getPrimaryAttribute(int attribute) {
    if (attribute == 1) {
      return 'Agility';
    } else if (attribute == 2) {
      return "Stength";
    } else if (attribute == 3) {
      return "Intelligence";
    } else {
      return "Universal";
    }
  }

  static Color getPrimaryAttributeColor(int attribute) {
    if (attribute == 1) {
      return Colors.green;
    } else if (attribute == 2) {
      return Colors.red;
    } else if (attribute == 3) {
      return Colors.blue;
    } else {
      return Colors.purple;
    }
  }

  static String getRoles(List<int> roles) {
    List<String> convertedRoles = [];

    for (int role in roles) {
      switch (role) {
        case 1:
          convertedRoles.add('Carry');
          break;
        case 2:
          convertedRoles.add('Mid');
          break;
        case 3:
          convertedRoles.add('Offlane');
          break;
        case 4:
          convertedRoles.add('Sup');
          break;
        case 5:
          convertedRoles.add('Hard sup');
          break;
        default:
          convertedRoles.add('Unknown');
          break;
      }
    }
    return convertedRoles.join(", ");
  }

  static String getGenderType(int attribute) {
    if (attribute == 1) {
      return 'Male';
    } else if (attribute == 2) {
      return "Female";
    } else {
      return "Genderless";
    }
  }

  static String getComplexityLevel(int attribute) {
    if (attribute == 1) {
      return "Easy";
    } else if (attribute == 2) {
      return "Medium";
    } else {
      return "Hard";
    }
  }
}
