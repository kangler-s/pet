/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-13 22:20:52
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-14 08:47:24
 * @FilePath: /pet/lib/widget/changeThemeButtonWidget.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pet/common/kThemes.dart';
import 'package:provider/provider.dart';
import 'package:get/instance_manager.dart';

// 切换主题按钮部件，用于切换暗黑模式
class ChnageThemeButtonWidget extends StatefulWidget {
  const ChnageThemeButtonWidget({super.key});

  @override
  State<ChnageThemeButtonWidget> createState() =>
      _ChnageThemeButtonWidgetState();
}

class _ChnageThemeButtonWidgetState extends State<ChnageThemeButtonWidget> {
  bool isDark = false;
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Switch.adaptive(
        value: themeController.themeMode.value == ThemeMode.dark,
        onChanged: (value) {
          themeController.toggleTheme(value);
        }));
  }
}
