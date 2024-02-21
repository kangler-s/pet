/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-14 22:47:36
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-17 20:02:39
 * @FilePath: /pet/lib/pages/category.dart
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:pet/common/httpClient.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:pet/common/kDataManager.dart';
import 'package:pet/common/kRouters.dart';
import 'package:pet/model/breed_item.dart';
import 'package:pet/widget/cacheImageWidget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var currentPage = 0;
  List<BreedItem> breedsList = [];
  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    super.initState();

    getBreedsData(false);
  }

  Future<List> getBreeds() async {
    List<Map<String, dynamic>>? data =
        await DatabaseManager().getData('Breeds');
    if (data != null && data.isNotEmpty) {
      return data;
    }
    dio.Response? res = await HttpClient().get('/v1/breeds',
        map: <String, dynamic>{'limit': 100, 'page': currentPage});
    if (res!.data != null) {
      List<dynamic> resList = res.data;
      for (dynamic element in resList) {
        BreedItem breed = BreedItem.fromJson(element);
        Map<String, dynamic> item = breed.toJson();
        await DatabaseManager().insertData('Breeds', item);
      }
      return resList;
    }
    return [];
  }

  void getBreedsData(isLoadMore) async {
    List<dynamic> resList = await getBreeds();
    if (resList.isNotEmpty) {
      List<BreedItem> breeds = [];
      for (dynamic element in resList) {
        BreedItem breed = BreedItem.fromJson(element);
        breeds.add(breed);
      }
      breedsList = breeds;
      // if (!isLoadMore) {
      //   // 使用map方法将动态列表转换为PetItem对象列表
      //   breedsList = breeds;
      //   _controller.finishRefresh();
      //   _controller.resetFooter();
      // } else {
      //   breedsList.addAll(breeds);
      //   _controller.finishLoad();
      // }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 13,
            crossAxisSpacing: 13,
          ),
          itemCount: breedsList.length,
          itemBuilder: (BuildContext context, int index) {
            BreedItem breed = breedsList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routers.BREEDINFO,
                  arguments: {'breed': breed},
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // 设置圆角半径
                child: CacheImageWidget(
                  width: double.infinity, // 设置宽度为整个父容器宽度
                  height: double.infinity, // 设置高度为整个父容器高度
                  imageUrl:
                      'https://cdn2.thecatapi.com/images/${breed?.referenceImageId}.jpg', //'${breed.image?.url}', //
                  fit: BoxFit.cover, // 使用BoxFit.fill来强制填充整个区域
                ),
              ),
            );
          },
        ),
      ),
    );
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
