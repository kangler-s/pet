/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-16 10:28:50
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-19 21:50:22
 * @FilePath: /pet/lib/common/kComSwiper.dart
 */
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class KComSwiper extends StatelessWidget {
  ///上下文
  final BuildContext context;

  ///轮播图滚动列表
  final List bannerList;

  ///高度可定制
  final double widgetHeight = 160;

  ///返回的item的定制
  final Function item;

  ///是否自动播放
  final bool autoPlay;

  ///点击的回调
  final Function? onTap;

  ///指点杆的布局
  final Alignment paginationAlignment;

  ///指点杆距离组件的距离
  final EdgeInsetsGeometry? paginationMargin;

  ///是否显示指点杆
  final bool showSwiperPagination;

  ///构造指点杆
  final SwiperPlugin? paginationBuilder;

  const KComSwiper(
      {Key? key,
      required this.bannerList,
      this.autoPlay = true,
      required this.item,
      required this.context,
      this.showSwiperPagination = true,
      this.onTap,
      this.paginationAlignment = Alignment.bottomRight,
      this.paginationMargin,
      this.paginationBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenHelper.width(context, widgetHeight),
      child: _swiper(),
    );
  }

  Widget _swiper() {
    return Swiper(
      containerHeight: 400,
      itemHeight: 500,
      onTap: (index) => {
        if (onTap != null) {onTap!(index)}
      },
      itemCount: bannerList.length,
//如果只有一个不自动播放,多个按需求是否播放
      autoplay: bannerList.length != 1 ? autoPlay : false,
      itemBuilder: (BuildContext context, int index) => item(bannerList[index]),

      ///如果只有一个不显示指示器或者按需显示指示器
      pagination: (bannerList.length != 1) && showSwiperPagination
          ? SwiperPagination(
              alignment: paginationAlignment,
              margin: paginationMargin ??
                  EdgeInsets.only(
                      right: ScreenHelper.width(context, 20),
                      bottom: ScreenHelper.width(context, 20)),
              builder: paginationBuilder ??
                  RectSwiperPaginationBuilder(
                      color: Theme.of(context).textTheme.caption?.color,
                      activeColor: Theme.of(context).indicatorColor,
                      size: Size(ScreenHelper.width(context, 12),
                          ScreenHelper.width(context, 12)),
                      activeSize: Size(ScreenHelper.width(context, 18),
                          ScreenHelper.width(context, 12))))
          : null,
    );
  }
}

class ScreenHelper {
  static double width(BuildContext context, double width) {
    // 获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;
    // 计算实际宽度
    return width * screenWidth / 375; // 375是设计稿的宽度
  }

  static double height(BuildContext context, double height) {
    // 获取屏幕高度
    double screenHeight = MediaQuery.of(context).size.height;
    // 计算实际高度
    return height * screenHeight / 812; // 812是设计稿的高度
  }
}


///---------------------- 指示器 --------------------------///

