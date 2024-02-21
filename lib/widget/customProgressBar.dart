/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-16 20:26:48
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-21 12:15:29
 * @FilePath: /pet/lib/widget/customProgressBar.dart
 */
import 'package:flutter/material.dart';
import 'package:pet/common/kColors.dart';

class CustomProgressBar extends StatelessWidget {
  final double percentage;
  final IconData iconData;
  final String text;
  final VoidCallback? onPressed;

  const CustomProgressBar(
      {super.key,
      required this.percentage,
      required this.iconData,
      required this.text,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    const double radius = 10;
    const double height = 50;
    return LayoutBuilder(builder: (context, constraints) {
      double widgetWidth = constraints.maxWidth;
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(0, 188, 107, 1), // 边框颜色
                  width: 5.0, // 边框宽度
                ),
                color: KColors()
                    .backgroudColor(), //Color.fromRGBO(43, 43, 43, .0),
                borderRadius: BorderRadius.circular(radius)),
            height: height, // 设置高度
          ),
          Positioned(
            child: Container(
              child: Stack(
                children: [
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 188, 107, 1), // 根据百分比填充颜色
                      borderRadius: percentage > 0.8
                          ? BorderRadius.circular(radius)
                          : const BorderRadius.only(
                              topLeft: Radius.circular(radius),
                              bottomLeft: Radius.circular(radius)),
                    ),
                    width: widgetWidth * percentage, // 根据百分比设置宽度
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16), // 设置内边距为8.0
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  style:
                      TextStyle(color: KColors().fanTextColor(), fontSize: 16),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
