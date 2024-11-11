import 'package:get/get.dart';

import '../controllers/toy_manager_page_controller.dart';

class ToyManagerPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToyManagerPageController>(
      () => ToyManagerPageController(),
    );
  }
}
