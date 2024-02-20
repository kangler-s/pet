/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-13 21:13:45
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-16 21:28:33
 * @FilePath: /pet/lib/pages/likes.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pet/widget/animationButton.dart';
import 'package:pet/widget/changeThemeButtonWidget.dart';

class LikesPage extends StatelessWidget {
  const LikesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Spacer(),
      IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
      ChnageThemeButtonWidget(),
      Center(
        child: Text('data'),
      ),
      BouncingButton(
        onTap: () {},
        title: 'ssss',
      ),
      Spacer(),
    ]);
  }
}
