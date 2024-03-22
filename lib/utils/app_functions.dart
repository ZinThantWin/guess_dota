import 'dart:convert';

import 'package:dota_guess_the_hero/render/c_render_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../render/m_render_model.dart';

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

  Future<void> getHeroesFromJSON() async {
    final RenderController controller = Get.put(RenderController());
    final String result = await rootBundle.loadString('assets/heroes.json');
    Map<String, dynamic> rawData = jsonDecode(result);
    controller.allHeroesList.clear();
    for (var r in rawData['heroes']) {
      controller.allHeroesList.add(RenderModel.fromJson(json: r));
    }
    if (controller.allHeroesList.length > 1) {
      controller.sortHeroesByAttributeAndName();
    }
    controller.update();
  }

  static String capitalizeAndMask(String input) {
    if (input.isEmpty) return input;

    // Split the input string by spaces
    List<String> words = input.split(" ");

    // Capitalize the first letter of each word and replace the rest with asterisks
    List<String> maskedWords = words.map((word) {
      if (word.isEmpty) return word;
      String capitalized =
          word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
      return capitalized.substring(0, 1) + '*' * (capitalized.length - 1);
    }).toList();

    // Join the masked words back together with spaces
    String maskedString = maskedWords.join(" ");

    return maskedString;
  }

  void main() {
    String input = "hello world";
    String maskedString = capitalizeAndMask(input);
    print(maskedString); // Output: H**** W****
  }

  static IconData getYearIcon(
      {required String selectedHeroReleaseYear,
      required String guessHeroReleaseYear}) {
    IconData iconData = Icons.add;
    int a = int.parse(selectedHeroReleaseYear);
    int b = int.parse(guessHeroReleaseYear);
    if (a > b) {
      iconData = TablerIcons.arrow_big_up_lines_filled;
    } else if (a < b) {
      iconData = TablerIcons.arrow_big_down_lines_filled;
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
