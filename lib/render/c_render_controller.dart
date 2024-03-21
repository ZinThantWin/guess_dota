import 'package:dota_guess_the_hero/render/m_render_model.dart';
import 'package:get/get.dart';

class RenderController extends GetxController {
  List<RenderModel> allHeroesList = [];
  int sortingType = 0;

  void sortByTypes() {
    if (sortingType == 0) {
      sortHeroesByMelee();
    } else if (sortingType == 1) {
      sortHeroesByGender();
    } else if (sortingType == 2) {
      sortHeroesDifficulty();
    } else {
      sortHeroesByAttributeAndName();
    }
    update();
  }

  void sortHeroesByMelee() {
    sortingType = 1;
    allHeroesList.sort((a, b) {
      int attributeComparison = a.rangeType.compareTo(b.rangeType);
      if (attributeComparison == 0) {
        return a.name.compareTo(b.name);
      }
      return attributeComparison;
    });
    // allHeroesList.sort((a, b) => a.rangeType.compareTo(b.rangeType));
  }

  void sortHeroesByGender() {
    sortingType = 2;
    allHeroesList.sort((a, b) {
      int attributeComparison = a.gender.compareTo(b.gender);
      if (attributeComparison == 0) {
        return a.name.compareTo(b.name);
      }
      return attributeComparison;
    });
    // allHeroesList.sort((a, b) => a.gender.compareTo(b.gender));
  }

  void sortHeroesDifficulty() {
    sortingType = 3;
    allHeroesList.sort((a, b) {
      int attributeComparison = a.complexityLevel.compareTo(b.complexityLevel);
      if (attributeComparison == 0) {
        return a.name.compareTo(b.name);
      }
      return attributeComparison;
    });
    // allHeroesList
    //     .sort((a, b) => a.complexityLevel.compareTo(b.complexityLevel));
  }

  void sortHeroesByAttributeAndName() {
    sortingType = 0;
    allHeroesList.sort((a, b) {
      int attributeComparison = a.attribute.compareTo(b.attribute);
      if (attributeComparison == 0) {
        return a.name.compareTo(b.name);
      }
      return attributeComparison;
    });
  }
}
