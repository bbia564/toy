import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toy_manager/app/modules/home/controllers/home_controller.dart';
import 'package:toy_manager/app/modules/plan_page/controllers/plan_page_controller.dart';
import 'package:toy_manager/utils/cs_aleart.dart';
import 'package:toy_manager/utils/cs_database_db.dart';

class MinePageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void cellClick(int index) {
    if (index == 0) {
      showclearAleart();
    } else if (index == 1) {
      Share.share('check out my website', subject: 'Look what I made!');
    } else if (index == 2) {
      showVersionAleart();
    } else if (index == 3) {
      showVersionAleart();
    }
  }

  void showclearAleart() {
    Get.dialog(Center(
      child: CSAleart(
        title: "Do you want Clear all Sales?",
        contentStr: "",
        okAction: () {
          cleanDatas();
        },
      ),
    ));
  }

  void showclearCartoonsAleart() {
    Get.dialog(Center(
      child: CSAleart(
        title: "Do you want Clear all Cartoons?",
        contentStr: "",
        okAction: () {
          cleanDatas();
        },
      ),
    ));
  }

  void showVersionAleart() {
    Get.dialog(Center(
      child: CSAleart(
        title: "App Version",
        contentStr: "V1.0.0",
        okAction: Get.back,
      ),
    ));
  }

  void cleanDatas() async {
    await TMDatabaseTool().clean();

    BotToast.showText(text: "Clear Success");
    Get.back();

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadAllToys();
    }
    if (Get.isRegistered<PlanPageController>()) {
      Get.find<PlanPageController>().loadallPlans();
    }
  }
}
