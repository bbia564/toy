import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:toy_manager/app/modules/toy_manager_page/views/toy_manager_cell.dart';
import 'package:toy_manager/utils/color_tool.dart';
import 'package:toy_manager/utils/componets.dart';

import '../controllers/toy_manager_page_controller.dart';

class ToyManagerPageView extends GetView<ToyManagerPageController> {
  const ToyManagerPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: tmText("Toys Manager"),
          centerTitle: true,
        ),
        body: tmContainer(
            radius: 10.w,
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.verticalSpace,
                  Row(
                    children: [
                      tmText("Info",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textColor: TMColorTool.tmColor("#767676")),
                      const Spacer(),
                      tmText("Status",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textColor: TMColorTool.tmColor("#767676")),
                      20.horizontalSpace,
                      tmText("operate",
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
                              return ToyManagerCell(
                                model: item,
                                deleteModel: (model) {
                                  controller.showDeletModelAleart(model);
                                },
                                toChange: (model) {
                                  controller.toChnage(model);
                                },
                              );
                            },
                          )),
                  )
                ])));
  }
}
