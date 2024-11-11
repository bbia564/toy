import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toy_manager/app/modules/plan_page/controllers/plan_page_controller.dart';
import 'package:toy_manager/utils/app_util.dart';
import 'package:toy_manager/utils/cs_database_db.dart';
import 'package:toy_manager/utils/toy_model.dart';

class ToyBuyPageController extends GetxController {
  final selectedToy = Rx<ToyModel?>(null);
  final priceContro = TextEditingController();



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
    priceContro.dispose();
    super.onClose();
  }

  void submit() async {
    if (selectedToy.value == null) {
      BotToast.showText(text: "Please selecte toy");

      return;
    }
    if (priceContro.text.isEmpty) {
      BotToast.showText(text: "Please input toy price");

      return;
    }

    try {
      final ppp = double.parse(priceContro.text);
      final model = PlanModel();
      model.tID = selectedToy.value?.id;
      model.name = selectedToy.value?.name;
      model.photo = selectedToy.value?.photo;
      model.status = selectedToy.value?.status;
      model.price = ppp;
      model.status = 0;
      model.localPhoto = selectedToy.value?.localPhoto;
      model.createTime =
          PMAppUtil.formatDateWithoutHour(dateTime: DateTime.now());

      await TMDatabaseTool().insertPlan(model);
      if (Get.isRegistered<PlanPageController>()) {
        Get.find<PlanPageController>().loadallPlans();
      }
      Get.back();
      BotToast.showText(text: "Add Success");
    } catch (e) {
      BotToast.showText(text: "Please check price format");
    }
  }
}
