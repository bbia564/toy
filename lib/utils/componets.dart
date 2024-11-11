import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toy_manager/utils/color_tool.dart';
import 'package:toy_manager/utils/permission_util.dart';

class CEKeepAliveWrapper extends StatefulWidget {
  const CEKeepAliveWrapper(
      {super.key, @required this.child, this.keepAlive = true});

  final Widget? child;
  final bool keepAlive;

  @override
  State<CEKeepAliveWrapper> createState() => _CEKeepAliveWrapperState();
}

class _CEKeepAliveWrapperState extends State<CEKeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child!;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(covariant CEKeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }
}

Container tmContainer(
    {double? width,
    double? height,
    double radius = 0,
    Color color = Colors.white,
    double borderWidth = 0.0,
    Color borderColor = const Color(0x00000fff),
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    Widget? child,
    Gradient? gradient,
    List<BoxShadow>? shadow,
    ImageProvider? bgImg,
    BoxFit? fit,
    Clip? clipBehavior}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: borderWidth),
        color: color,
        gradient: gradient,
        boxShadow: shadow,
        image: bgImg != null
            ? DecorationImage(
                image: bgImg,
                fit: fit ?? BoxFit.contain,
              )
            : null),
    alignment: alignment,
    padding: padding,
    margin: margin,
    clipBehavior: clipBehavior ?? Clip.antiAlias,
    child: child,
  );
}

Widget tmText(
  String text, {
  double fontSize = 16,
  Color? textColor,
  FontWeight fontWeight = FontWeight.bold,
  int?maxlenght,
  TextAlign? textAline
}) {
  return Text(
    text,
    maxLines: maxlenght,
    textAlign: textAline,
    style: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: fontSize.sp,
        
        fontWeight: fontWeight),
  );
}

Widget tmDivider() {
  return Divider(
    color: TMColorTool.tmColor("#EBEBEB"),
    height: 1,
    thickness: 0,
    indent: 0,
    endIndent: 0,
  );
}

Future<XFile?> tmPickSingleImageXFile() async {
  bool status = false;
  if (Platform.isAndroid) {
    Permission permission = await PermissionUtil.getMediumPermission();
    status = await PermissionUtil.checkPermission([permission]);
  } else {
    status = true;
  }

  if (status) {
    final picker = ImagePicker();
    final res = await picker.pickImage(
      imageQuality: 90,
      maxWidth: 1024,
      source: ImageSource.gallery,
    );

    return res;
  }
  return null;
}

tmShowDatePicker(String title, Function(DateTime chooseDateTime) saveAction,
    {CupertinoDatePickerMode type = CupertinoDatePickerMode.date,
    DateTime? maxDatetime,
    DateTime? minDatetime,
    DateTime? initialDateTime}) {
  var today = DateTime.now();
  late DateTime chooseDate = DateTime.now();
  Get.bottomSheet(Container(
    height: 300,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.w))),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close_fullscreen_outlined,
                    color: TMColorTool.tmColor("#AAAAAA"),
                  )),
              tmText(title, fontWeight: FontWeight.w400),
              TextButton(
                  onPressed: () {
                    saveAction(chooseDate);
                    Get.back();
                  },
                  child: tmText("Save", textColor: TMColorTool.tmColor("#AAAAAA")))
            ],
          ),
        ),
        tmDivider(),
        Expanded(
          flex: 1,
          child: CupertinoDatePicker(
            mode: type,
            initialDateTime:
                initialDateTime ?? DateTime(today.year, today.month, today.day),
            minimumDate: minDatetime ?? DateTime(1970, 1, 1),
            maximumDate:
                maxDatetime ?? DateTime(today.year, today.month, today.day),
            maximumYear:
                maxDatetime != null ? maxDatetime.year : DateTime.now().year,
            minimumYear: minDatetime?.year ?? 1970,
            use24hFormat: true,
            onDateTimeChanged: (dayTime) {
              chooseDate = dayTime;
            },
          ),
        )
      ],
    ),
  ));
}
