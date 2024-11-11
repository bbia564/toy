import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toy_manager/app/modules/plan_page/views/plan_cell.dart';
import 'package:toy_manager/utils/base_view.dart';
import 'package:toy_manager/utils/color_tool.dart';
import 'package:toy_manager/utils/componets.dart';
import '../controllers/plan_page_controller.dart';

class PlanPageView extends TMStackBaseView<PlanPageController> {
  const PlanPageView({super.key});

  @override
  String viewTitle() {
    return "Plan";
  }

  @override
  Widget contentViewBuild(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed('/toy-buy-page',arguments: {});
          },
          child: tmContainer(
          radius: 10.w,
          height: 54.w,
          borderWidth: 2,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          borderColor: TMColorTool.tmColor("#C9CDFF"),
          alignment: Alignment.center,
          child: tmText("Add Plan", textColor: TMColorTool.blueColor),
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
                        child: Obx(() => controller.allPlans.isEmpty
                            ? Center(
                                child: tmText("no datas",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    textColor: TMColorTool.tmColor("#999999")),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: controller.allPlans.length,
                                itemBuilder: (context, index) {
                                  final item = controller.allPlans[index];
                                  return PlanCell(model: item);
                                },
                              ))),
                  ],
                )))
      ],
    );
  }
}
