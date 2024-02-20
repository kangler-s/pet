/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-16 09:47:13
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-18 20:00:27
 * @FilePath: /pet/lib/pages/breedInfo.dart
 */
import 'dart:ffi';
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:pet/common/httpClient.dart';
import 'package:flutter/material.dart';
import 'package:pet/common/kColors.dart';
import 'package:pet/common/kComSwiper.dart';
import 'package:pet/common/kRouters.dart';
import 'package:pet/model/breed_item.dart';
import 'package:pet/model/pet_item.dart';
import 'package:pet/widget/cacheImageWidget.dart';
import 'package:pet/widget/customProgressBar.dart';

class BreedInfoPage extends StatefulWidget {
  const BreedInfoPage({super.key});

  @override
  State<BreedInfoPage> createState() => _BreedInfoPageState();
}

class _BreedInfoPageState extends State<BreedInfoPage> {
  List<String> breedImages = [];
  BreedItem breed = Get.arguments['breed'];
  List<String> propertysNames1 = [
    'Affection Level',
    'Adaptability',
    'Energy Level',
    'Intelligence',
    'Vocalisation',
    'SocialNeeds'
  ];
  List<String> propertysNames2 = [
    'Stranger Friendly',
    'Grooming',
    'Child Friendly',
    'HealthIssues',
    'Dog Friendly',
    'SheddingLevel'
  ];
  List<double> propertysValue1 = [];
  List<double> propertysValue2 = [];

  @override
  void initState() {
    super.initState();
    propertyData();
    getBreedImages();
  }

  void propertyData() {
    //情感水平-适应性-能量水平-情报-发声-社会需求
    propertysValue1 = [
      breed.affectionLevel?.toDouble() ?? 0,
      breed.adaptability?.toDouble() ?? 0,
      breed.energyLevel?.toDouble() ?? 0,
      breed.intelligence?.toDouble() ?? 0,
      breed.vocalisation?.toDouble() ?? 0,
      breed.socialNeeds?.toDouble() ?? 0,
    ];
    //陌生人友好-梳理-儿童友好型-健康问题-狗友-脱落水平
    propertysValue2 = [
      breed.strangerFriendly?.toDouble() ?? 0,
      breed.grooming?.toDouble() ?? 0,
      breed.childFriendly?.toDouble() ?? 0,
      breed.healthIssues?.toDouble() ?? 0,
      breed.dogFriendly?.toDouble() ?? 0,
      breed.sheddingLevel?.toDouble() ?? 0,
    ];

    setState(() {});
  }

  void getBreedImages() async {
    dio.Response? res = await HttpClient().get('/v1/images/search',
        map: <String, dynamic>{'limit': 10, 'breed_id': breed.id});
    if (res?.data != null) {
      List<dynamic> resList = res!.data;
      List<PetItem> breedimgList =
          resList.map((item) => PetItem.fromJson(item)).toList();
      for (PetItem pet in breedimgList) {
        breedImages.add(pet.url!);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                color: Color.fromRGBO(96, 96, 96, 0.4),
                height: ScreenHelper.height(
                        context, MediaQuery.of(context).size.width) -
                    100,
                child: KComSwiper(
                    bannerList: breedImages,
                    item: (item) {
                      return Container(
                        child: CacheImageWidget(
                          imageUrl: item,
                          height: ScreenHelper.height(
                                  context, MediaQuery.of(context).size.width) -
                              100,
                        ),
                      );
                    },
                    context: context),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 30,
                color: KColors().backgroudColor(),
                onPressed: () {
                  Get.back(result: false);
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.park),
                iconSize: 30,
                color: KColors().backgroudColor(),
                onPressed: () {
                  Get.toNamed(Routers.SELECTBREED,
                      arguments: {'breed1': breed});
                },
              ),
            ),
            Positioned.fill(
              top: 292,
              bottom: MediaQuery.of(context).padding.bottom,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: KColors().backgroudColor(),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            child: Text(
                              '${breed.description}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                            propertysNames1.length,
                            (index) {
                              double value = propertysValue1[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 7),
                                child: CustomProgressBar(
                                  percentage: (value / 5),
                                  iconData: Icons.info,
                                  text: '${propertysNames1[index]}',
                                  onPressed: () {
                                    print('--- ${propertysNames1[index]}');
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Column(
                          children: List.generate(
                            (propertysNames2.length * 0.5).toInt(),
                            (index) {
                              double value1 = propertysValue2[index];
                              double value2 = propertysValue2[index + 1];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 7),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomProgressBar(
                                        percentage: (value1 / 5),
                                        iconData: Icons.info,
                                        text: '${propertysNames2[index]}',
                                        onPressed: () {
                                          print(
                                              '--- ${propertysNames2[index]}');
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CustomProgressBar(
                                        percentage: (value2 / 10),
                                        iconData: Icons.info,
                                        text: '${propertysNames2[index + 1]}',
                                        onPressed: () {
                                          print(
                                              '--- ${propertysNames2[index + 1]}');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
