/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-13 21:14:17
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-17 11:11:25
 * @FilePath: /pet/lib/common/kcolors.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pet/common/kThemes.dart';
import 'package:get/get.dart';

class KColors {
  static const Color themeColor_light = Color.fromRGBO(161, 178, 117, 1);
  static const Color themeColor_dark = Color.fromRGBO(78, 78, 78, 1);

  static const Color cardColor_light = Color.fromRGBO(117, 175, 178, 1);
  static const Color cardColor_dark = Color.fromRGBO(15, 7, 67, 1);

  static const Color buttonColor_light = Color.fromRGBO(75, 149, 186, 1);
  static const Color buttonColor_dark = Color.fromRGBO(75, 149, 186, 1);

  static const Color barColor_dark = Color.fromRGBO(15, 7, 67, 1);

  static const Color backgroudColor_light = Color.fromARGB(255, 255, 255, 255);
  static const Color backgroudColor_dark = Color.fromRGBO(43, 43, 43, 1);

  static const Color fanTextColor_light = Color.fromARGB(255, 18, 18, 18);
  static const Color fanTextColor_dark = Color.fromARGB(255, 233, 232, 240);

  static const Color pageBackground = Color(0xFF282E45);
  static const Color contentColorPurple = Color(0xFF6E1BFF);

  final ThemeController themeController = Get.find();

  Color textColor() {
    return themeController.themeMode.value != ThemeMode.dark
        ? fanTextColor_dark
        : fanTextColor_light;
  }

  Color fanTextColor() {
    return themeController.themeMode.value != ThemeMode.dark
        ? fanTextColor_light
        : fanTextColor_dark;
  }

  Color backgroudColor() {
    return themeController.themeMode.value != ThemeMode.dark
        ? backgroudColor_light
        : backgroudColor_dark;
  }

  Color cardColor() {
    return themeController.themeMode.value != ThemeMode.dark
        ? cardColor_light
        : cardColor_dark;
  }

  Color buttonColor() {
    return themeController.themeMode.value != ThemeMode.dark
        ? buttonColor_light
        : buttonColor_dark;
  }

  Color randomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // 生成0到255之间的随机红色值
      random.nextInt(256), // 生成0到255之间的随机绿色值
      random.nextInt(256), // 生成0到255之间的随机蓝色值
      1.0, // 不透明度为1
    );
  }
}
