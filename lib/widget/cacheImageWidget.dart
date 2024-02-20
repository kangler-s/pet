/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-15 10:31:53
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-17 17:47:03
 * @FilePath: /pet/lib/widget/caCheImageWidget.dart
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/common/kThemes.dart';
import 'package:provider/provider.dart';

///带缓存的 图片组件
///[imageUrl] 图片路径
///[height] 高度
///[width]宽度
///[fit] BoxFit
class CacheImageWidget extends StatelessWidget {
  final String imageUrl; //图片地址可能是网络也可能是本地
  final double? height; //图片的高度
  final double? width; //图片的宽度
  final BoxFit? fit; //图片的缩放模式
  ///简单的列了几个使用到的,如果需要更多配置点进去源码都有写
  const CacheImageWidget(
      {Key? key, required this.imageUrl, this.height, this.width, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //通过Provider获取当前是否是夜间模式
    var theme = Theme.of(context);
    final ThemeController themeController = Get.find();
    //使用Stack是为了给图片盖上一个蒙版
    return Stack(
      children: [
        //如果当前文件路径不存在/assets/image 的时候代表是网络图片 走CaChedNetWorkImage 如果不是那就走本地图片显示
        //Constants.imageLocalPath 是自己定义的字符串常量 取决你把本地图片放在哪里了
        !imageUrl.contains('/assets/')
            ? Center(
                child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: width ?? double.infinity,
                    height: height,
                    fit: fit ?? BoxFit.cover,
                    placeholder: (
                      BuildContext context,
                      String url,
                    ) =>
                        Container(
                          color: const Color.fromRGBO(189, 189, 189, .5),
                          // child:
                          //     const Center(child: CircularProgressIndicator()),
                        ),
                    errorWidget: (
                      BuildContext context,
                      String url,
                      dynamic error,
                    ) {
                      return Container(
                        color: const Color.fromRGBO(189, 189, 189, .5),
                        child: const Icon(Icons.error),
                      );
                    }),
              )
            : Image.asset(
                imageUrl,
                width: width,
                height: height,
                fit: fit ?? BoxFit.cover,
              ),
        Container(
          width: width,
          height: height,
          //如果是深色模式就加上一个black26 白天就透明色
          color: themeController.themeMode.value == ThemeMode.dark
              ? Colors.black26
              : Colors.transparent,
        )
      ],
    );
  }
}
