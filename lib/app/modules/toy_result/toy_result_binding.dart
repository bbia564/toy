import 'package:get/get.dart';

import 'toy_result_logic.dart';

class ToyResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
