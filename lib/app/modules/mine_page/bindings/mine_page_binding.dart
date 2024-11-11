import 'package:get/get.dart';

import '../controllers/mine_page_controller.dart';

class MinePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MinePageController>(
      () => MinePageController(),
    );
  }
}
