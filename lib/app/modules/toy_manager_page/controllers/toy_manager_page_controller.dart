import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toy_manager/app/modules/home/controllers/home_controller.dart';
import 'package:toy_manager/utils/cs_aleart.dart';
import 'package:toy_manager/utils/cs_database_db.dart';
import 'package:toy_manager/utils/toy_model.dart';

class ToyManagerPageController extends GetxController {
  final allToys = <ToyModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadAllToys();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toChnage(ToyModel mode) {
    Get.toNamed('/toy-add-page', arguments: {"model": mode});
  }

  void showDeletModelAleart(ToyModel mode) {
    Get.dialog(Center(
      child: CSAleart(
        title: "Do you want delete this toy?",
        contentStr: "Tips",
        okAction: () {
          deletModel(mode);
        },
      ),
    ));
  }

  void deletModel(ToyModel mode) async {
    await TMDatabaseTool().deletToyModel(mode);
    loadAllToys();
    Get.find<HomeController>().loadAllToys();

    Get.back();
    BotToast.showText(text: "Delete Success");
  }

  void loadAllToys() async {
    allToys.value = await TMDatabaseTool().allToy();
  }
}
