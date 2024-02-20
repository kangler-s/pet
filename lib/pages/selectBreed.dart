/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-17 17:48:50
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-17 20:14:59
 * @FilePath: /pet/lib/pages/selectBreed.dart
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/common/kColors.dart';
import 'package:pet/common/kDataManager.dart';
import 'package:pet/common/kRouters.dart';
import 'package:pet/model/breed_item.dart';
import 'package:pet/widget/cacheImageWidget.dart';

class SelectBreedPage extends StatefulWidget {
  const SelectBreedPage({super.key});

  @override
  State<SelectBreedPage> createState() => _SelectBreedPageState();
}

class _SelectBreedPageState extends State<SelectBreedPage> {
  List<BreedItem> breedsList = [];
  BreedItem breed1 = Get.arguments['breed1'];

  @override
  void initState() {
    super.initState();
    getBreedsData();
  }

  Future<List> getBreeds() async {
    List<Map<String, dynamic>>? data =
        await DatabaseManager().getData('Breeds');
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return [];
  }

  void getBreedsData() async {
    List<dynamic> resList = await getBreeds();

    if (resList.isNotEmpty) {
      List<BreedItem> breeds = [];
      for (dynamic element in resList) {
        BreedItem breed = BreedItem.fromJson(element);
        breeds.add(breed);
      }
      print('resList[0] = ${breeds[0].adaptability}');
      setState(() {
        breedsList = breeds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择pk的品种'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView.builder(
        itemCount: breedsList.length,
        itemBuilder: (BuildContext context, int index) {
          BreedItem breed = breedsList[index];
          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: GestureDetector(
              onTap: () {
                print('breed2 = ${breed.toJson()}');
                Get.toNamed(Routers.BREEDCOMPARE,
                    arguments: {'breed1': breed1, 'breed2': breed});
              },
              child: Container(
                decoration: BoxDecoration(
                    color: KColors().backgroudColor(),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Container(
                        child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: CacheImageWidget(
                        width: 70, // 设置宽度为整个父容器宽度
                        height: 70, // 设置高度为整个父容器高度
                        imageUrl:
                            'https://cdn2.thecatapi.com/images/${breed?.referenceImageId}.jpg',
                        fit: BoxFit.cover, // 使用BoxFit.fill来强制填充整个区域
                      ),
                    )),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(child: Text('${breed.name}')),
                    Spacer()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
