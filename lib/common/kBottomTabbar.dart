/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-14 09:27:58
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-20 16:32:18
 * @FilePath: /pet/lib/common/kBottomTabbar.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pet/common/kThemes.dart';
import 'package:pet/common/kcolors.dart';
import 'package:pet/pages/category.dart';
import 'package:pet/pages/home.dart';
import 'package:pet/pages/likes.dart';
import 'package:pet/pages/test.dart';
import 'package:pet/pages/vote.dart';

class KBottomTabbar extends StatefulWidget {
  const KBottomTabbar({super.key});

  @override
  State<KBottomTabbar> createState() => _KBottomTabbarState();
}

class _KBottomTabbarState extends State<KBottomTabbar> {
  var _selectIndex = 0;

  List<Widget> tabViewList = [
    const HomePage(),
    VotePage(),
    const CategoryPage(),
    const LikesPage(),
    RadarChartSample1()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        ///IndexedStack 保留页面切换的状态 不会每次执行initState
        index: _selectIndex,
        children: tabViewList,
      ),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'home'),
          TabItem(icon: Icons.thumb_up, title: 'vote'),
          TabItem(icon: Icons.category, title: 'category'),
          TabItem(icon: Icons.favorite, title: 'favorite'),
          TabItem(icon: Icons.heart_broken, title: 'test'),
        ],
        onTap: onItemTapped,
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        top: -16,
      ),
    );
  }
}
