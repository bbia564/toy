import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toy_manager/utils/color_tool.dart';
import 'package:toy_manager/utils/componets.dart';
import 'package:toy_manager/utils/toy_model.dart';

class ToysCell extends StatelessWidget {
  final ToyModel model;
  const ToysCell({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isLocaImg = model.photo?.isEmpty ?? true;
    final isIntact = model.status == 1;
    return SizedBox(
      height: 74.w,
      child: Row(
        children: [
          isLocaImg
              ? Image.asset(
                  model.localPhoto!,
                  height: 48.w,
                  width: 48.w,
                  fit: BoxFit.cover,
                )
              : Image.memory(
                  base64Decode(model.photo!),
                  height: 48.w,
                  width: 48.w,
                  fit: BoxFit.cover,
                ),
          10.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tmText(model.name ?? "", fontSize: 14),
              4.verticalSpace,
              tmText(model.createTime ?? "",
                  fontSize: 14, textColor: TMColorTool.tmColor("#B9B9B9"))
            ],
          ),
          const Spacer(),
          tmText(isIntact ? "Intact" : "Damaged",
              fontSize: 14,
              textColor: isIntact
                  ? TMColorTool.tmColor("#19B125")
                  : TMColorTool.tmColor("#B9B9B9"))
        ],
      ),
    );
  }
}
