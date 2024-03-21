import 'dart:convert';
import 'package:dota_guess_the_hero/guess_hero/v_guess_hero_page.dart';
import 'package:dota_guess_the_hero/render/c_render_controller.dart';
import 'package:dota_guess_the_hero/render/m_render_model.dart';
import 'package:dota_guess_the_hero/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/app_functions.dart';

class RenderPage extends StatefulWidget {
  const RenderPage({super.key});

  @override
  State<RenderPage> createState() => _RenderPageState();
}

class _RenderPageState extends State<RenderPage> {
  final RenderController controller = Get.put(RenderController());
  @override
  void initState() {
    initLoad();
    super.initState();
  }

  void initLoad() async {
    final String result = await rootBundle.loadString('assets/heroes.json');
    Map<String, dynamic> rawData = jsonDecode(result);
    for (var r in rawData['heroes']) {
      controller.allHeroesList.add(RenderModel.fromJson(json: r));
    }
    if (controller.allHeroesList.length > 1) {
      controller.sortHeroesByAttributeAndName();
    }
    controller.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RenderController>(builder: (controller) {
        return Stack(
          children: [
            ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.allHeroesList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Row(
                    children: [
                      Expanded(child: sortButton()),
                      Expanded(child: guessButton()),
                    ],
                  );
                } else {
                  return eachHero(controller.allHeroesList[index - 1], index);
                }
              },
              separatorBuilder: (a, b) {
                return const Divider(
                  color: Colors.black,
                  height: 0,
                );
              },
            ),
          ],
        );
      }),
    );
  }

  Widget sortButton() {
    return GestureDetector(
      onTap: () {
        controller.sortByTypes();
      },
      child: Container(
        height: Get.width * 0.13,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(width: 1), color: Colors.red.withOpacity(1)),
        child: Center(
          child: FittedBox(
            child: Text(
              AppFunctions.getSortingType(controller.sortingType),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget guessButton() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const GuessHeroPage());
      },
      child: Container(
        height: Get.width * 0.13,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(width: 1), color: Colors.red.withOpacity(1)),
        child: const Center(
          child: FittedBox(
            child: Text(
              "Start game",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget eachHero(RenderModel hero, int index) {
    return Container(
      decoration: BoxDecoration(
          color: AppFunctions.getPrimaryAttributeColor(hero.attribute)
              .withOpacity(0.3)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text("${index}."),
          5.widthBox(),
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
                Text("${hero.position}/ ${hero.releasedYear.toString()}"),
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
    );
  }
}
