import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:toy_manager/assets/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TMStackBaseView<T extends GetxController> extends GetView<T> {
  const TMStackBaseView({super.key});

  Widget _buildBgView() {
    return Image.asset(
      bgImage(),
      width: 1.sw,
      fit: BoxFit.fitHeight,
    );
  }

  String viewTitle();
  String bgImage() => Assets.backgroundBg;
  Widget contentViewBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            viewTitle(),
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            _buildBgView(),
            Positioned(
              top:
                  kMinInteractiveDimension + MediaQuery.of(context).padding.top,
              bottom: 0,
              right: 0,
              left: 0,
              child: contentViewBuild(context),
            ),
          ],
        ));
  }
}
