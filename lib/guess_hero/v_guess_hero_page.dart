import 'dart:math';

import 'package:dota_guess_the_hero/guess_hero/c_guess_hero_controller.dart';
import 'package:dota_guess_the_hero/utils/app_constants.dart';
import 'package:dota_guess_the_hero/utils/extensions/sized_box_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GetBuilder<GuessHeroController>(builder: (controller) {
          return Text((controller.guessedHeroList.length > 9)
              ? AppFunctions.capitalizeAndMask(controller.selectedHero!.name)
              : "${10 - controller.guessedHeroList.length} more tries for hint");
        }),
      ),
      body: GetBuilder<GuessHeroController>(builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
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
            10.widthBox(),
            SizedBox(
              height: 170,
              width: Get.width * 0.25,
              child: Column(
                children: [
                  heroImage(imageUrl: guessedHero.image),
                  10.heightBox(),
                  nameCard(name: guessedHero.name)
                ],
              ),
            ),
            10.widthBox(),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      eachHeroTile(title: "Gender", data: guessedHero.gender),
                      eachHeroTile(
                          title: "Range Type", data: guessedHero.rangeType),
                      eachHeroTile(
                          title: "Attribute", data: guessedHero.attribute),
                    ],
                  ),
                  10.heightBox(),
                  Row(
                    children: [
                      eachHeroTile(
                          title: "Complexity",
                          data: guessedHero.complexityLevel),
                      eachHeroTile(
                          title: "Release Year",
                          data: guessedHero.releasedYear),
                      eachHeroTile(
                          title: "Move Style", data: guessedHero.moveStyle),
                    ],
                  ),
                  10.heightBox(),
                  Row(
                    children: [
                      eachHeroTile(
                          title: "Position", data: guessedHero.position),
                      eachHeroTile(title: "Species", data: guessedHero.species),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        35.heightBox()
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   child: Divider(
        //     height: 20,
        //     color: Colors.black,
        //   ),
        // )
      ],
    );
  }

  Widget nameCard({required String name}) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        color: const Color(0xff373737),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          name,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget heroImage({required String imageUrl}) {
    return Container(
      width: Get.width * 0.3,
      height: 110,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget eachHeroTile(
      {required String title, required var data, double height = 50}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: SizedBox(
          height: height,
          child: title == "Position"
              ? Container(
                  decoration: BoxDecoration(
                      color: controller.getValidationColor(
                          type: title, data: data),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      5.widthBox(),
                      Transform.rotate(
                        angle: 45 * (pi / 180),
                        child: const Icon(
                          TablerIcons.topology_ring,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      5.widthBox(),
                      Expanded(
                        child: Text(
                          data.join(", "),
                          maxLines: 5,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                )
              : title == "Species"
                  ? Container(
                      decoration: BoxDecoration(
                          color: controller.getValidationColor(
                              type: title, data: data),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          5.widthBox(),
                          const Icon(
                            TablerIcons.dog,
                            color: Colors.white,
                            size: 15,
                          ),
                          5.widthBox(),
                          Expanded(
                            child: Flexible(
                              child: Text(
                                data.join(", "),
                                maxLines: 5,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: controller.getValidationColor(
                              type: title, data: data),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          5.widthBox(),
                          Icon(
                            title == "Gender"
                                ? TablerIcons.gender_bigender
                                : title == "Complexity"
                                    ? TablerIcons.puzzle
                                    : title == "Attribute"
                                        ? TablerIcons.triangle_square_circle
                                        : title == "Range Type"
                                            ? TablerIcons.location
                                            : title == "Move Style"
                                                ? TablerIcons.chevrons_right
                                                : TablerIcons.calendar_due,
                            color: Colors.white,
                            size: 15,
                          ),
                          5.widthBox(),
                          Expanded(
                            child: Text(
                              data,
                              maxLines: 5,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          if (title == "Release Year" &&
                              AppFunctions.getYearIcon(
                                      guessHeroReleaseYear: data,
                                      selectedHeroReleaseYear: controller
                                          .selectedHero!.releasedYear) !=
                                  Icons.add)
                            Icon(
                              AppFunctions.getYearIcon(
                                  guessHeroReleaseYear: data,
                                  selectedHeroReleaseYear:
                                      controller.selectedHero!.releasedYear),
                              color: Colors.white,
                              size: 17,
                            ),
                          5.widthBox()
                        ],
                      ),
                    ),
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
                      reverse: true,
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
        decoration: const BoxDecoration(color: Colors.white),
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
                      width: 2,
                    )),
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
                    hero.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              ),
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
