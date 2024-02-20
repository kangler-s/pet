/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-13 21:54:40
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-15 15:53:42
 * @FilePath: /pet/lib/common/kThemes.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:pet/common/kcolors.dart';

// 自定义主题数据
class MyThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: KColors.themeColor_light, // 设置浅色主题的背景颜色
    colorScheme: ColorScheme.light(), // 设置浅色主题的颜色方案
    primaryColor: Colors.amber,
    iconTheme: IconThemeData(color: Colors.green, opacity: 1),
    bottomAppBarTheme: BottomAppBarTheme(color: KColors.themeColor_light),
    cardColor: KColors.cardColor_light,
    hoverColor: KColors.buttonColor_light,
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: KColors.themeColor_dark, // 设置深色主题的背景颜色
    colorScheme: ColorScheme.dark(), // 设置深色主题的颜色方案
    primaryColor: Colors.amber,
    iconTheme: IconThemeData(color: Colors.green, opacity: 1),
    bottomAppBarTheme: BottomAppBarTheme(color: KColors.themeColor_dark),
    cardColor: KColors.cardColor_dark,
    hoverColor: KColors.buttonColor_dark,
  );
}

// --------1、 使用ChangeNotifier 管理--------
// 主题管理器，负责管理主题状态和切换
class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark; // 默认主题模式为深色模式

  bool get isDarkMode => themeMode == ThemeMode.dark; // 判断当前是否为深色模式

  // 切换主题模式
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light; // 根据开关状态切换主题模式
    notifyListeners(); // 通知监听器主题状态已更新
  }
}

// --------2、 使用getx 管理--------
// 主题控制器，用于管理主题状态
class ThemeController extends GetxController {
  // 使用 Rx 变量来实现响应式状态
  var themeMode = ThemeMode.system.obs;

  // 切换主题模式
  void toggleTheme(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
  }

  // 判断当前主题是否为 light 模式
  bool isLightMode() {
    return themeMode.value == ThemeMode.light;
  }
}
