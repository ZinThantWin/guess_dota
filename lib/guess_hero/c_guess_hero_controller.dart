import 'dart:math';
import 'package:dota_guess_the_hero/render/c_render_controller.dart';
import 'package:dota_guess_the_hero/render/m_render_model.dart';
import 'package:dota_guess_the_hero/utils/app_colors.dart';
import 'package:dota_guess_the_hero/utils/app_colors.dart';
import 'package:dota_guess_the_hero/utils/app_colors.dart';
import 'package:dota_guess_the_hero/utils/app_colors.dart';
import 'package:dota_guess_the_hero/utils/app_colors.dart';
import 'package:dota_guess_the_hero/utils/app_colors.dart';
import 'package:dota_guess_the_hero/utils/app_colors.dart';
import 'package:dota_guess_the_hero/utils/app_constants.dart';
import 'package:dota_guess_the_hero/utils/gobal_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_functions.dart';

class GuessHeroController extends GetxController {
  final RenderController renderController = Get.find();

  RenderModel? selectedHero;
  List<RenderModel> suggestSearchHeroList = [];
  List<RenderModel> tempAllHeroesList = [];
  List<RenderModel> guessedHeroList = [];
  bool xSearching = false;
  bool xCorrectGuess = false;

  @override
  Future<void> onInit() async {
    await AppFunctions().getHeroesFromJSON();
    tempAllHeroesList.clear();
    tempAllHeroesList = renderController.allHeroesList;
    update();
    getSelectedHero();
    super.onInit();
  }

  TextEditingController searchTEC = TextEditingController();
  FocusNode searchFN = FocusNode();

  void onSelectSearchedHero(RenderModel hero) {
    var tempHeroModel = RenderModel(
        moveStyle: hero.moveStyle,
        name: hero.name,
        species: hero.species,
        position: hero.position,
        attribute: hero.attribute,
        complexityLevel: hero.complexityLevel,
        gender: hero.gender,
        image: hero.image,
        rangeType: hero.rangeType,
        releasedYear: hero.releasedYear,
        selectedDateTime: DateTime.now());
    guessedHeroList.add(tempHeroModel);
    if (guessedHeroList.length > 1) {
      guessedHeroList.sort(
        (a, b) => a.selectedDateTime.compareTo(b.selectedDateTime),
      );
    }
    searchTEC.clear();
    searchFN.unfocus();
    xSearching = false;
    checkIfSelectedHeroIsRight(hero);
    update();
    update([AppConstants.searchID]);
  }

  void checkIfSelectedHeroIsRight(RenderModel hero) {
    if (hero.name == selectedHero!.name) {
      xCorrectGuess = true;
      Get.dialog(
        const AlertDialog(
          title: Text(
            "Congratulations",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
      );
    }
  }

  void onChanged(String input) {
    if (input.isNotEmpty) {
      xSearching = true;
      filterSearch(input);
    } else {
      xSearching = false;
    }
    update([AppConstants.searchID]);
  }

  void onTapOutSide() {
    searchFN.unfocus();
    xSearching = false;
    update([AppConstants.searchID]);
  }

  void onTap() {
    if (searchTEC.text.isNotEmpty) {
      xSearching = true;
      update([AppConstants.searchID]);
    }
  }

  Color getValidationColor({required String type, required var data}) {
    Color validationColor = Colors.white;
    if (type == "Gender") {
      validationColor = getGenderValidationColor(data: data);
    } else if (type == "Attribute") {
      validationColor = getAttributeValidationColor(data: data);
    } else if (type == "Range Type") {
      validationColor = getRangeTypeValidationColor(data: data);
    } else if (type == "Complexity") {
      validationColor = getComplexityValidationColor(data: data);
    } else if (type == "Position" || type == "Species") {
      validationColor = getRolesAndSpeciesValidationColor(
          data: data, xSpecies: type == "Species");
    } else if (type == "Move Style") {
      validationColor = getMoveStyleValidationColor(data: data);
    } else {
      validationColor = getReleaseYearValidationColor(data: data);
    }
    return validationColor;
  }

  Color getRolesAndSpeciesValidationColor(
      {required List<String> data, required bool xSpecies}) {
    var data2 = xSpecies ? selectedHero!.species : selectedHero!.position;
    data.sort();
    data2.sort();
    if (data.length == data2.length &&
        data.every((element) => data2.contains(element))) {
      return AppColors.greenColor;
    } else {
      for (var r in data) {
        if (data2.contains(r)) {
          return AppColors.yellowColor;
        }
      }
      return AppColors.redColor;
    }
  }

  Color getGenderValidationColor({required String data}) {
    if (data.toUpperCase() == selectedHero!.gender.toUpperCase()) {
      return AppColors.greenColor;
    } else {
      return AppColors.redColor;
    }
  }

  Color getMoveStyleValidationColor({required String data}) {
    if (data.toUpperCase() == selectedHero!.moveStyle.toUpperCase()) {
      return AppColors.greenColor;
    } else {
      return AppColors.redColor;
    }
  }

  Color getAttributeValidationColor({required String data}) {
    if (data.toUpperCase() == selectedHero!.attribute.toUpperCase()) {
      return AppColors.greenColor;
    } else {
      return AppColors.redColor;
    }
  }

  Color getRangeTypeValidationColor({required String data}) {
    if (data.toUpperCase() == selectedHero!.rangeType.toUpperCase()) {
      return AppColors.greenColor;
    } else {
      return AppColors.redColor;
    }
  }

  Color getReleaseYearValidationColor({required String data}) {
    if (data == selectedHero!.releasedYear) {
      return AppColors.greenColor;
    } else {
      return AppColors.redColor;
    }
  }

  Color getComplexityValidationColor({required String data}) {
    if (data.toUpperCase() == selectedHero!.complexityLevel.toUpperCase()) {
      return AppColors.greenColor;
    } else {
      return AppColors.redColor;
    }
  }

  void filterSearch(String input) {
    suggestSearchHeroList.clear();
    for (var r in guessedHeroList) {
      tempAllHeroesList.removeWhere((element) => element.name == r.name);
    }
    superPrint(tempAllHeroesList.length);
    suggestSearchHeroList = tempAllHeroesList
        .where((element) =>
            element.name.toUpperCase().contains(input.toUpperCase()))
        .toList();
  }

  void getSelectedHero() {
    Random random = Random();
    int selectedHeroId = random.nextInt(tempAllHeroesList.length);
    selectedHero = tempAllHeroesList[selectedHeroId];
    // Future.delayed(const Duration(seconds: 2)).then((value) => update());
  }
}
