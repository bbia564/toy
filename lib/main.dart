import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:toy_manager/utils/app_util.dart';
import 'package:toy_manager/utils/color_tool.dart';

import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/modules/mine_page/bindings/mine_page_binding.dart';
import 'app/modules/mine_page/views/mine_page_view.dart';
import 'app/modules/plan_page/bindings/plan_page_binding.dart';
import 'app/modules/plan_page/views/plan_page_view.dart';
import 'app/modules/root_page/bindings/root_page_binding.dart';
import 'app/modules/root_page/views/root_page_view.dart';
import 'app/modules/toy_add_page/bindings/toy_add_page_binding.dart';
import 'app/modules/toy_add_page/views/toy_add_page_view.dart';
import 'app/modules/toy_buy_page/bindings/toy_buy_page_binding.dart';
import 'app/modules/toy_buy_page/views/toy_buy_page_view.dart';
import 'app/modules/toy_manager_page/bindings/toy_manager_page_binding.dart';
import 'app/modules/toy_manager_page/views/toy_manager_page_view.dart';

void main() {
  runApp(_initApp());
}

Widget ceInitGetMaterialApp({
  Widget Function(BuildContext, Widget?)? builder,
}) {
  return GetMaterialApp(
    darkTheme: ThemeData.dark(),
    useInheritedMediaQuery: true,
    themeMode: ThemeMode.light,
    fallbackLocale: const Locale("en", "US"),
    debugShowCheckedModeBanner: false,
    initialRoute: '/root-page',
    getPages: Pages,
    defaultTransition: Transition.rightToLeft,
    theme: ThemeData(
        scaffoldBackgroundColor: TMColorTool.tmColor("#F7F5F8"),
        indicatorColor: Colors.grey,
        brightness: Brightness.light,
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.white.withOpacity(0),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.white)),
    builder: builder,
    navigatorObservers: [BotToastNavigatorObserver()],
    supportedLocales: const [
      Locale('en', 'US'),
    ],
    localizationsDelegates: const [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
  );
}

_initApp() {
  if (!kIsWeb && Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  BotToast.defaultOption.notification.animationDuration =
      const Duration(seconds: 2);

  Widget body = ceInitGetMaterialApp(
    builder: (context, child) {
      final botToastBuilder = BotToastInit();

      return ScreenUtilInit(
        designSize: const Size(375, 812),
        useInheritedMediaQuery: true,
        builder: (p0, p1) {
          Widget body = GestureDetector(
            onTap: () {
              PMAppUtil.keyboardDis(context);
            },
            child: child,
          );
          body = botToastBuilder(context, body);
          return body;
        },
      );
    },
  );
  return body;
}

List<GetPage<dynamic>> Pages = [
  GetPage(
    name: '/home',
    page: () => const HomeView(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/root-page',
    page: () => const RootPageView(),
    binding: RootPageBinding(),
  ),
  GetPage(
    name: '/plan-page',
    page: () => const PlanPageView(),
    binding: PlanPageBinding(),
  ),
  GetPage(
    name: '/mine-page',
    page: () => const MinePageView(),
    binding: MinePageBinding(),
  ),
  GetPage(
    name: '/toy-add-page',
    page: () => const ToyAddPageView(),
    binding: ToyAddPageBinding(),
  ),
  GetPage(
    name: '/toy-buy-page',
    page: () => const ToyBuyPageView(),
    binding: ToyBuyPageBinding(),
  ),
  GetPage(
    name: '/toy-manager-page',
    page: () => const ToyManagerPageView(),
    binding: ToyManagerPageBinding(),
  ),
];
