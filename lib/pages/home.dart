/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-13 21:13:14
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-17 21:08:22
 * @FilePath: /pet/lib/pages/home.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:dio/dio.dart' as dio;
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:pet/common/httpClient.dart';
import 'package:pet/common/kThemes.dart';
import 'package:pet/common/photoScreen.dart';
import 'package:pet/model/pet_item.dart';

GlobalKey _headerKey = GlobalKey();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = 0;
  List<PetItem> petList = [];
  EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    super.initState();
    getPetList(false);
  }

  void getPetList(isLoadMore) async {
    dio.Response? res = await HttpClient().get('/v1/images/search',
        map: <String, dynamic>{
          'has_breeds': true,
          'order': 'ASC',
          'limit': 15,
          'page': currentPage
        });
    if (res!.data != null) {
      List<dynamic> resList = res.data;
      List<PetItem> pets =
          resList.map((item) => PetItem.fromJson(item)).toList();
      if (!isLoadMore) {
        // 使用map方法将动态列表转换为PetItem对象列表
        petList = pets;
        _controller.finishRefresh();
        _controller.resetFooter();
      } else {
        petList.addAll(pets);
        _controller.finishLoad();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: EasyRefresh(
            header: _defaultHeader(),
            footer: _defaultFooter(),
            onRefresh: () {
              currentPage = 0;
              getPetList(false);
            },
            onLoad: () {
              currentPage++;
              getPetList(true);
            },
            child: Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: CustomHeaderDelegate(
                      key: _headerKey,
                      child: Container(
                        child: const Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 40,
                              child: Text(
                                '找到你喜欢的',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                                left: 20,
                                top: 90,
                                child: Text(
                                  '伙伴',
                                  style: TextStyle(fontSize: 20),
                                )),
                            Positioned(
                              right: 15,
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/icon_home_top.png')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(10.0),
                    sliver: SliverMasonryGrid.count(
                      crossAxisCount: 2, // 每排显示两个
                      mainAxisSpacing: 10, // 设置间距
                      crossAxisSpacing: 10,
                      childCount: petList.length,
                      itemBuilder: (context, index) {
                        PetItem pet = petList[index];
                        // item
                        return GestureDetector(
                          onTap: () {
                            Get.to(PhotoScreen(imgList: [pet.url], index: 0));
                          },
                          child: Container(
                              // 随机高度
                              height: pet.width! > pet.height! ? 180 : 260,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).cardColor,
                                  image: DecorationImage(
                                    image: NetworkImage(pet.url!),
                                    fit: BoxFit.cover,
                                  )),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 25,
                                  alignment: Alignment.bottomLeft,
                                  color: Colors.amber,
                                  // child: Text('${pet.breeds![0].name}'),
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//自定义headerview 代理
class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final GlobalKey key;

  CustomHeaderDelegate({required this.child, required this.key});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      key: key,
      child: child,
    );
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 200.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

_defaultHeader() {
  return const ClassicHeader(
    dragText: '下拉刷新',
    armedText: '释放刷新',
    readyText: '加载中...',
    processingText: '加载中...',
    processedText: '加载完成',
    noMoreText: '没有更多',
    failedText: '加载失败',
    messageText: '最后更新于 %T',
  );
}

_defaultFooter() {
  return const ClassicFooter(
    dragText: '上拉加载',
    armedText: '释放刷新',
    readyText: '加载中...',
    processingText: '加载中...',
    processedText: '加载完成',
    noMoreText: '没有更多',
    failedText: '加载失败',
    messageText: '最后更新于 %T',
    showMessage: false, // 隐藏更新时间
  );
}
