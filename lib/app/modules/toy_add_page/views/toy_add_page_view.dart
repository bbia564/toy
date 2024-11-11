import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:toy_manager/assets/assets.dart';
import 'package:toy_manager/utils/color_tool.dart';
import 'package:toy_manager/utils/componets.dart';

import '../controllers/toy_add_page_controller.dart';

class ToyAddPageView extends GetView<ToyAddPageController> {
  const ToyAddPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => tmText(controller.isEdit.isTrue ? "Edit" : "Add Toy")),
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
              SizedBox(
                height: 58,
                width: double.infinity,
                child: Row(
                  children: [
                    tmText("Name"),
                    10.horizontalSpace,
                    Expanded(
                        child: TextField(
                            controller: controller.inputContro,
                            textAlign: TextAlign.right,
                            maxLength: 30,
                            maxLines: 1,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                            decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: 'input toy name',
                                hintStyle: TextStyle(
                                    color: TMColorTool.tmColor('#8C8C8C'),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal))))
                  ],
                ),
              ),
              tmDivider(),
              18.verticalSpace,
              tmText("  Select image", fontSize: 14),
              14.verticalSpace,
              InkWell(
                onTap: controller.selectPic,
                child: tmContainer(
                  radius: 10.w,
                  height: 98.w,
                  width: 98.w,
                  color: TMColorTool.tmColor("#F0F0F0"),
                  child: Obx(() {
                    if (controller.isEdit.isTrue) {
                      final isLocaImg =
                          controller.toyModel?.photo?.isEmpty ?? true;
                      return isLocaImg
                          ? Image.asset(
                              controller.toyModel!.localPhoto!,
                              height: 98.w,
                              width: 98.w,
                              fit: BoxFit.cover,
                            )
                          : Image.memory(
                              base64Decode(controller.toyModel!.photo!),
                              height: 98.w,
                              width: 98.w,
                              fit: BoxFit.cover,
                            );
                    } else {
                      return Obx(() => controller.imageData.isEmpty
                          ? const SizedBox.shrink()
                          : Image.memory(
                              base64Decode(controller.imageData.value),
                              height: 98.w,
                              width: 98.w,
                              fit: BoxFit.cover,
                            ));
                    }
                  })),
              ),
              14.verticalSpace,
              tmDivider(),
              14.verticalSpace,
              Row(
                children: [
                  tmText("Status", fontSize: 14),
                  const Spacer(),
                  Obx(() {
                    final isGood = controller.isGood.isTrue;
                    return InkWell(
                        onTap: () {
                          controller.isGood.value = true;
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              isGood
                                  ? Assets.selectedIcon
                                  : Assets.unselectedIcon,
                              height: 14.w,
                              width: 14.w,
                            ),
                            8.horizontalSpace,
                            tmText("Intact",
                                fontSize: 14,
                                textColor: isGood
                                    ? TMColorTool.blueColor
                                    : TMColorTool.tmColor("#505050"),
                                fontWeight:
                                    isGood ? FontWeight.w600 : FontWeight.w400),
                          ],
                        ));
                  }),
                  10.horizontalSpace,
                  Obx(() {
                    final isGood = controller.isGood.isFalse;
                    return InkWell(
                      onTap: () {
                        controller.isGood.value = false;
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            isGood
                                ? Assets.selectedIcon
                                : Assets.unselectedIcon,
                            height: 14.w,
                            width: 14.w,
                          ),
                          8.horizontalSpace,
                          tmText("Damaged",
                              fontSize: 14,
                              textColor: isGood
                                  ? TMColorTool.blueColor
                                  : TMColorTool.tmColor("#505050"),
                              fontWeight:
                                  isGood ? FontWeight.w600 : FontWeight.w400),
                        ],
                      ),
                    );
                  })
                ],
              ),
              14.verticalSpace,
              tmDivider(),
              26.verticalSpace,
              InkWell(
                onTap: controller.submit,
                child: tmContainer(
                  radius: 4.w,
                  height: 44.w,
                  width: double.infinity,
                  color: TMColorTool.blueColor,
                  alignment: Alignment.center,
                  child:
                      tmText("Submit", fontSize: 14, textColor: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
