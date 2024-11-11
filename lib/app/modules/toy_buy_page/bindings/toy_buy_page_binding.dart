import 'package:get/get.dart';

import '../controllers/toy_buy_page_controller.dart';

class ToyBuyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToyBuyPageController>(
      () => ToyBuyPageController(),
    );
  }
}
