import 'package:get/get.dart';
import 'package:toy_manager/app/modules/root_page/controllers/root_page_controller.dart';
import 'package:toy_manager/utils/cs_database_db.dart';
import 'package:toy_manager/utils/toy_model.dart';

class HomeController extends GetxController {
  final allToys = <ToyModel>[].obs;
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

  void itemClick(int index) {
    if (index == 0) {
      Get.toNamed('/toy-add-page', arguments: {});
    } else if (index == 1) {
      Get.toNamed('/toy-manager-page', arguments: {});
    } else if (index == 2) {
      final vc = Get.find<RootPageController>();
      vc.pageController.jumpToPage(1);
      vc.changeCurrentPageIndex(1);

    }
  }

  void loadAllToys() async {
    allToys.value = await TMDatabaseTool().allToy();
  }
}
