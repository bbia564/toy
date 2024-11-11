import 'package:get/get.dart';
import 'package:toy_manager/utils/cs_database_db.dart';
import 'package:toy_manager/utils/toy_model.dart';

class PlanPageController extends GetxController {
 
  final allPlans = <PlanModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadallPlans();
  }

  @override
  void onClose() {
    super.onClose();
  }



  void loadallPlans() async {
    allPlans.value = await TMDatabaseTool().getAllPlanDetail();
  }
}
