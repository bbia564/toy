import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toy_manager/app/modules/home/views/toys_cell.dart';
import 'package:toy_manager/assets/assets.dart';
import 'package:toy_manager/utils/base_view.dart';
import 'package:toy_manager/utils/color_tool.dart';
import 'package:toy_manager/utils/componets.dart';
import '../controllers/home_controller.dart';

class HomeView extends TMStackBaseView<HomeController> {
  const HomeView({super.key});

  Widget _item(String icon, String t, int index) {
    return Flexible(
        child: InkWell(
      onTap: () {
        controller.itemClick(index);
      },
      child: tmContainer(
          radius: 10.w,
          borderWidth: 2,
          width: double.infinity,
          height: double.infinity,
          borderColor: TMColorTool.tmColor("#C9CDFF"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                height: 32.w,
                width: 32.w,
              ),
              8.verticalSpace,
              tmText(t, textColor: TMColorTool.blueColor),
            ],
          )),
    ));
  }

  @override
  Widget contentViewBuild(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 96.w,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _item(Assets.addIcon, "Add Toy", 0),
              10.horizontalSpace,
              _item(Assets.managerIcon, "Manage", 1),
              10.horizontalSpace,
              _item(Assets.buyPlan, "Wish List", 2)
            ],
          ),
        ),
        Expanded(
            child: tmContainer(
                radius: 10.w,
                margin: EdgeInsets.all(16.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tmText("Info",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: TMColorTool.tmColor("#767676")),
                        tmText("Status",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: TMColorTool.tmColor("#767676")),
                      ],
                    ),
                    12.verticalSpace,
                    tmDivider(),
                    Expanded(
                        child: Obx(() => controller.allToys.isEmpty
                            ? Center(
                                child: tmText("no datas",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    textColor: TMColorTool.tmColor("#999999")),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: controller.allToys.length,
                                itemBuilder: (context, index) {
                                  final item = controller.allToys[index];
                                  return InkWell(
                                    onTap: () {
                                      // Get.toNamed(Routes.CARTOON_SALE_DETAIL,arguments: {"model":item});
                                    },
                                    child: ToysCell(model: item),
                                  );
                                },
                              ))),
                  ],
                )))
      ],
    );
  }

  @override
  String viewTitle() {
    return "Toy";
  }
}
