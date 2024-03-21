import 'package:dota_guess_the_hero/guess_hero/c_guess_hero_controller.dart';
import 'package:dota_guess_the_hero/utils/app_constants.dart';
import 'package:dota_guess_the_hero/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../render/m_render_model.dart';
import '../utils/app_functions.dart';

class GuessHeroPage extends StatefulWidget {
  const GuessHeroPage({super.key});

  @override
  State<GuessHeroPage> createState() => _GuessHeroPageState();
}

class _GuessHeroPageState extends State<GuessHeroPage> {
  final GuessHeroController controller = Get.put(GuessHeroController());

  @override
  void initState() {
    controller.getSelectedHero();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<GuessHeroController>(builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    guessedHeroesListWidget(),
                  ],
                ),
              ),
            ),
            30.heightBox(),
            suggestedSearchList(),
            if (!controller.xCorrectGuess) searchField(),
            30.heightBox()
          ],
        );
      }),
    );
  }

  Widget guessedHeroesListWidget() {
    return Column(
      children:
          controller.guessedHeroList.map((e) => eachGuessedHero(e)).toList(),
    );
  }

  Widget eachGuessedHero(RenderModel guessedHero) {
    return Column(
      children: [
        Row(
          children: [
            eachHeroTile(title: "Hero", data: guessedHero.image),
            eachHeroTile(title: "Gender", data: guessedHero.gender),
            eachHeroTile(title: "Attribute", data: guessedHero.attribute),
          ],
        ),
        5.heightBox(),
        Row(
          children: [
            eachHeroTile(title: "Range Type", data: guessedHero.rangeType),
            eachHeroTile(
                title: "Complexity", data: guessedHero.complexityLevel),
            eachHeroTile(title: "Release Year", data: guessedHero.releasedYear),
            eachHeroTile(title: "Position", data: guessedHero.position),
          ],
        ),
        20.heightBox()
      ],
    );
  }

  Widget eachHeroTile({required String title, required var data}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          children: [
            FittedBox(
              child: Text(
                title.toUpperCase(),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: title == "Hero"
                  ? Image.network(
                      data,
                      fit: BoxFit.cover,
                    )
                  : title == "Position"
                      ? Container(
                          color: controller.getValidationColor(
                              type: title, data: data),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data.join(", "),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          color: controller.getValidationColor(
                              type: title, data: data),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data,
                              ),
                              if (title == "Release Year" &&
                                  AppFunctions.getYearIcon(
                                          guessHeroReleaseYear: data,
                                          selectedHeroReleaseYear: controller
                                              .selectedHero!.releasedYear) !=
                                      Icons.add)
                                Icon(AppFunctions.getYearIcon(
                                    guessHeroReleaseYear: data,
                                    selectedHeroReleaseYear:
                                        controller.selectedHero!.releasedYear))
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget suggestedSearchList() {
    return GetBuilder<GuessHeroController>(
        id: AppConstants.searchID,
        builder: (controller) {
          return controller.xSearching
              ? Container(
                  color: Colors.transparent,
                  height: Get.height * 0.3,
                  width: Get.width,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return eachHero(
                            controller.suggestSearchHeroList[index]);
                      },
                      separatorBuilder: (_, a) {
                        return const Divider(
                          height: 0,
                        );
                      },
                      itemCount: controller.suggestSearchHeroList.length),
                )
              : Container();
        });
  }

  Widget eachHero(RenderModel hero) {
    return GestureDetector(
      onTap: () {
        controller.onSelectSearchedHero(hero);
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppFunctions.getPrimaryAttributeColor(hero.attribute)
                .withOpacity(0.3)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
                width: Get.width * 0.15,
                height: Get.width * 0.15,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 3,
                        color: AppFunctions.getPrimaryAttributeColor(
                            hero.attribute))),
                child: ClipOval(
                  child: Image.network(
                    width: Get.width * 0.2,
                    height: Get.width * 0.2,
                    hero.image,
                    fit: BoxFit.cover,
                  ),
                )),
            10.widthBox(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${hero.name} / ${hero.rangeType}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(hero.position.join(", ")),
                ],
              ),
            ),
            10.widthBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hero.complexityLevel),
                Text(hero.gender),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        controller: controller.searchTEC,
        focusNode: controller.searchFN,
        onTapOutside: (_) {
          // controller.onTapOutSide();
        },
        onTap: () {
          controller.onTap();
        },
        onChanged: (input) {
          controller.onChanged(input);
        },
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            hintText: "Search",
            border: InputBorder.none),
      ),
    );
  }
}
