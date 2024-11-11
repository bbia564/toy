import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toy_manager/utils/color_tool.dart';
import 'package:toy_manager/utils/componets.dart';
import 'package:toy_manager/utils/toy_model.dart';

class ToyManagerCell extends StatelessWidget {
  final ToyModel model;
  final Function(ToyModel model) deleteModel;
  final Function(ToyModel model) toChange;
  const ToyManagerCell(
      {super.key,
      required this.model,
      required this.toChange,
      required this.deleteModel});

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
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: tmText(model.name ?? "", fontSize: 14,maxlenght: 2)),
                  5.horizontalSpace,
                  InkWell(
                    onTap: () {
                      deleteModel(model);
                    },
                    child: Icon(
                      Icons.delete,
                      size: 16.w,
                      color: TMColorTool.blueColor,
                    ),
                  )
                ],
              ),
              4.verticalSpace,
              tmText(model.createTime ?? "",
                  fontSize: 14, textColor: TMColorTool.tmColor("#B9B9B9"),maxlenght: 1)
            ],
          )),
          const Spacer(),
          tmText(isIntact ? "Intact" : "Damaged",
              fontSize: 14,
              textColor: isIntact
                  ? TMColorTool.tmColor("#19B125")
                  : TMColorTool.tmColor("#B9B9B9")),
          20.horizontalSpace,
          InkWell(
            onTap: () {
              toChange(model);
            },
            child: Text(
              "Edit",
              style: TextStyle(
                  color: TMColorTool.blueColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }
}
