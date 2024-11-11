import 'package:get/get.dart';

import '../controllers/toy_add_page_controller.dart';

class ToyAddPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToyAddPageController>(
      () => ToyAddPageController(),
    );
  }
}
