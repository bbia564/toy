import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:toy_manager/assets/assets.dart';
import 'package:toy_manager/utils/color_tool.dart';
import 'package:toy_manager/utils/componets.dart';
import 'package:toy_manager/utils/cs_database_db.dart';
import 'package:toy_manager/utils/toy_model.dart';

import '../controllers/toy_buy_page_controller.dart';

class ToyBuyPageView extends GetView<ToyBuyPageController> {
  const ToyBuyPageView({super.key});
  @override
  Widget build(BuildContext context) {
    final slKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: tmText("Add Plan"),
        centerTitle: true,
      ),
      body: tmContainer(
          radius: 10.w,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          margin: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 58.w,
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    showPopup(context, slKey);
                  },
                  child: Row(
                    children: [
                      tmText("Select Toy", fontSize: 14),
                      10.horizontalSpace,
                      const Spacer(),
                      Obx(() {
                        final hasModel = controller.selectedToy.value != null;
                        return tmText(
                            hasModel
                                ? controller.selectedToy.value?.name ?? ""
                                : "Select Toy",
                            fontSize: 14,
                            textColor: hasModel
                                ? Colors.black
                                : TMColorTool.tmColor("#D9D9D9"));
                      }),
                      4.horizontalSpace,
                      Image.asset(
                        key: slKey,
                        Assets.arrow,
                        height: 16.w,
                        width: 16.w,
                      )
                    ],
                  ),
                ),
              ),
              tmDivider(),
              SizedBox(
                height: 58.w,
                width: double.infinity,
                child: InkWell(
                  child: Row(
                    children: [
                      tmText("Toy Price", fontSize: 14),
                      10.horizontalSpace,
                      Expanded(
                          child: TextField(
                              controller: controller.priceContro,
                              textAlign: TextAlign.right,
                              maxLength: 30,
                              maxLines: 1,
                              inputFormatters: [TMTextInputFormatter()],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.sp),
                              decoration: InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintText: 'input toy price',
                                  hintStyle: TextStyle(
                                      color: TMColorTool.tmColor('#8C8C8C'),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal))))
                    ],
                  ),
                ),
              ),
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
              ),
              20.verticalSpace
            ],
          )),
    );
  }

  void showPopup(BuildContext context, GlobalKey key) async {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final allToys = await TMDatabaseTool().allToy();

    final list = <PopupMenuItem<ToyModel>>[];
    for (var item in allToys) {
      list.add(PopupMenuItem<ToyModel>(
        value: item,
        child: Text(item.name ?? ""),
      ));
    }

    final ToyModel? selectedValue = await showMenu(
      context: context,
      color: Colors.white,
      position:
          RelativeRect.fromLTRB(offset.dx, offset.dy, offset.dx, offset.dy),
      items: list,
      elevation: 8.0,
    );

    if (selectedValue != null) {
      controller.selectedToy.value = selectedValue;
    }
  }
}

class TMTextInputFormatter extends TextInputFormatter {
  final RegExp _exp = RegExp(r'^\d{0,5}(\.\d{0,2})?$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_exp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
