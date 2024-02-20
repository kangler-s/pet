/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-13 21:14:33
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-15 13:43:18
 * @FilePath: /pet/lib/application.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pet/common/kBottomTabbar.dart';
import 'package:pet/common/kRouters.dart';
import 'package:pet/common/kThemes.dart';

// 应用程序主体部分，负责整体布局和主题切换
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '主题',
      theme: MyThemes.lightTheme, // 设置浅色主题
      darkTheme: MyThemes.darkTheme, // 设置深色主题
      initialRoute: Routers.INITIAL,
      getPages: AppPages.pages,
      home: const KBottomTabbar(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => ThemeProvider(),
  //     builder: (context, _) {
  //       // 获取当前的主题状态
  //       final themePrivider = Provider.of<ThemeProvider>(context);
  //       return MaterialApp(
  //         debugShowCheckedModeBanner: false,
  //         title: '主题',
  //         themeMode: themePrivider.themeMode, // 设置主题模式
  //         theme: MyThemes.lightTheme, // 设置浅色主题
  //         darkTheme: MyThemes.darkTheme, // 设置深色主题
  //         home: HomePage(),
  //       );
  //     },
  //   );
  // }
}
