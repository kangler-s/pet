import 'package:flutter/material.dart';
import 'package:pet/common/kColors.dart';

class CustomProgressBar extends StatelessWidget {
  final double percentage;
  final IconData iconData;
  final String text;
  final VoidCallback? onPressed;

  CustomProgressBar(
      {required this.percentage,
      required this.iconData,
      required this.text,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double radius = 10;
    final double height = 50;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(0, 188, 107, 1), // 边框颜色
                width: 5.0, // 边框宽度
              ),
              color:
                  KColors().backgroudColor(), //Color.fromRGBO(43, 43, 43, .0),
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
                    color: Color.fromRGBO(0, 188, 107, 1), // 根据百分比填充紫色
                    borderRadius: percentage == 1
                        ? BorderRadius.circular(radius)
                        : BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            bottomLeft: Radius.circular(radius)),
                  ),
                  width: MediaQuery.of(context).size.width *
                      percentage, // 根据百分比设置宽度
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
          left: 10,
          right: 10,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: KColors().fanTextColor(), fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
