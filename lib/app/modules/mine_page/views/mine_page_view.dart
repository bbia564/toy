import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toy_manager/assets/assets.dart';
import 'package:toy_manager/utils/base_view.dart';
import 'package:toy_manager/utils/componets.dart';
import '../controllers/mine_page_controller.dart';

class MinePageView extends TMStackBaseView<MinePageController> {
  const MinePageView({super.key});
  @override
  Widget contentViewBuild(BuildContext context) {
    final items = ["Clean sales", "Share", "About"];
    return tmContainer(
      radius: 10.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.cellClick(index);
              },
              child: SizedBox(
                height: 44.w,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    tmText(items[index], fontSize: 14),
                    const Spacer(),
                    Image.asset(
                      Assets.arrow,
                      height: 16.w,
                      width: 16.w,
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => tmDivider(),
          itemCount: items.length),
    );
  }

  @override
  String viewTitle() {
    return "Settings";
  }
}
