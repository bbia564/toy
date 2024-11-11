import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toy_manager/app/modules/home/views/home_view.dart';
import 'package:toy_manager/app/modules/mine_page/views/mine_page_view.dart';
import 'package:toy_manager/app/modules/plan_page/views/plan_page_view.dart';

class RootPageController extends GetxController {
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  List<Widget> pageList = [
    const HomeView(),
    const PlanPageView(),
    const MinePageView(),
  ];

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

  void changeCurrentPageIndex(int index) {
    currentIndex.value = index;
  }


}
