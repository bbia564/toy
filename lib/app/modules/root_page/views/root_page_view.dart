import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:toy_manager/assets/assets.dart';
import 'package:toy_manager/utils/color_tool.dart';

import '../controllers/root_page_controller.dart';

class RootPageView extends GetView<RootPageController> {
  const RootPageView({super.key});

  Widget _tbTbarItem(String name) {
    return Image.asset(
      name,
      height: 22.h,
      width: 22.h,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              controller.currentIndex.value = value;
            },
            children: controller.pageList,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            fixedColor: TMColorTool.blueColor,
            onTap: (value) {
              controller.currentIndex.value = value;
              controller.pageController.jumpToPage(value);
            },
            items: [
              BottomNavigationBarItem(
                  icon: _tbTbarItem(Assets.homeSel),
                  activeIcon: _tbTbarItem(Assets.homeSelected),
                  label: "Toys"),
              BottomNavigationBarItem(
                  icon: _tbTbarItem(Assets.planNoraml),
                  activeIcon: _tbTbarItem(Assets.planSelected),
                  label: "Plan"),
              BottomNavigationBarItem(
                label: "Mine",
                icon: _tbTbarItem(Assets.setNormal),
                activeIcon: _tbTbarItem(Assets.setSelected),
              )
            ],
          ),
        ));
  }
}
