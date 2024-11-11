import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toy_manager/app/modules/home/controllers/home_controller.dart';
import 'package:toy_manager/app/modules/toy_manager_page/controllers/toy_manager_page_controller.dart';
import 'package:toy_manager/utils/app_util.dart';
import 'package:toy_manager/utils/componets.dart';
import 'package:toy_manager/utils/cs_database_db.dart';
import 'package:toy_manager/utils/toy_model.dart';

class ToyAddPageController extends GetxController {
  final isEdit = false.obs;
  final imageData = "".obs;
  final isGood = true.obs;

  ToyModel? toyModel;

  final inputContro = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    toyModel = Get.arguments["model"];
    if (toyModel != null) {
      isEdit.value = true;
      inputContro.text = toyModel?.name ?? "";
    }
  }

  @override
  void onClose() {
    inputContro.dispose();
    super.onClose();
  }

  void selectPic() async {
    final file = await tmPickSingleImageXFile();
    if (file == null) {
      return;
    }

    final bytes = await file.readAsBytes();
    imageData.value = base64Encode(bytes);
  }

  void submit() async {
    if (inputContro.text.isEmpty) {
      BotToast.showText(text: "Please input toy name");

      return;
    }

    if (isEdit.isTrue) {
      if ((toyModel!.localPhoto?.isEmpty ?? true) && imageData.isEmpty) {
        BotToast.showText(text: "Please selected toy image");

        return;
      }

      toyModel!.name = inputContro.text;
      toyModel!.photo = imageData.value;
      toyModel!.localPhoto = toyModel!.localPhoto;
      toyModel!.status = isGood.isTrue ? 1 : 0;
      toyModel!.price = 0.0;

      await TMDatabaseTool().updateToyData(toyModel!);
    } else {
      if (imageData.isEmpty) {
        BotToast.showText(text: "Please selected toy image");
        return;
      }

      final model = ToyModel();
      model.name = inputContro.text;
      model.photo = imageData.value;
      model.status = isGood.isTrue ? 1 : 0;
      model.price = 0.0;
      model.localPhoto = "";
      model.createTime =
          PMAppUtil.formatDateWithoutHour(dateTime: DateTime.now());

      await TMDatabaseTool().insertToyData(model);
    }

    if (Get.isRegistered<ToyManagerPageController>()) {
      Get.find<ToyManagerPageController>().loadAllToys();
    }
    Get.find<HomeController>().loadAllToys();
    Get.back();
    BotToast.showText(text: isEdit.isTrue ? "Update Success" : "Add Success");
  }
}
