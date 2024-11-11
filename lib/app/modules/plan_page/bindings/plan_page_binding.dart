import 'package:get/get.dart';

import '../controllers/plan_page_controller.dart';

class PlanPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanPageController>(
      () => PlanPageController(),
    );
  }
}
