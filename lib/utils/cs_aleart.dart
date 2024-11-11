
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toy_manager/utils/color_tool.dart';
import 'package:toy_manager/utils/componets.dart';

class CSAleart extends StatelessWidget {
  final String title;
  final String contentStr;
  final Function() okAction;
  final Function()? cancleAction;
  const CSAleart(
      {super.key,
      this.cancleAction,
      required this.okAction,
      required this.title,
      required this.contentStr});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: tmContainer(
            radius: 10.w,
            width: 300.w,
            height: 170.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                14.verticalSpace,
                tmText(title, fontSize: 14),
                13.verticalSpace,
                tmText(contentStr),
                20.verticalSpace,
                Divider(
                  color: TMColorTool.tmColor("#EFEFEF"),
                ),
                SizedBox(
                  height: 46.h,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: Get.back,
                          child: Container(
                            alignment: Alignment.center,
                            child: tmText("Cancel",
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      tmContainer(
                        height: 30.h,
                        width: 1,
                        color: TMColorTool.tmColor("#EFEFEF"),
                      ),
                      Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: okAction,
                            child: Container(
                              alignment: Alignment.center,
                              child: tmText("YES",
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            )));
  }
}
