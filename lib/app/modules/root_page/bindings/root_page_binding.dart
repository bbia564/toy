import 'package:get/get.dart';
import 'package:toy_manager/app/modules/home/controllers/home_controller.dart';
import 'package:toy_manager/app/modules/mine_page/controllers/mine_page_controller.dart';
import 'package:toy_manager/app/modules/plan_page/controllers/plan_page_controller.dart';
import 'package:toy_manager/utils/cs_database_db.dart';
import 'package:toy_manager/utils/pm_share_per.dart';

import '../controllers/root_page_controller.dart';

class RootPageBinding extends Bindings {
  @override
  void dependencies() {
    TMSharedPreferences.initialize();
    TMDatabaseTool().init();
    Get.lazyPut<RootPageController>(
      () => RootPageController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<PlanPageController>(
      () => PlanPageController(),
    );
    Get.lazyPut<MinePageController>(
      () => MinePageController(),
    );
  }
}
