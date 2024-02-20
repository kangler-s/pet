/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-16 22:51:58
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-18 19:59:29
 * @FilePath: /pet/lib/pages/breedcCompare.dart
 */
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/common/kColors.dart';
import 'package:pet/model/breed_item.dart';
import 'package:pet/widget/cacheImageWidget.dart';
import 'package:pet/widget/radarChartWidget.dart';

class BreedComparePage extends StatefulWidget {
  const BreedComparePage({super.key});

  @override
  State<BreedComparePage> createState() => _BreedComparePageState();
}

class _BreedComparePageState extends State<BreedComparePage> {
  BreedItem breed1 = Get.arguments['breed1'];
  BreedItem breed2 = Get.arguments['breed2'];

  static List<String> targetNames1 = [
    'Affection Level',
    'Adaptability',
    'Energy Level',
    'Intelligence',
    'Vocalisation',
    'SocialNeeds'
  ];
  static List<String> targetNames2 = [
    'Stranger Friendly',
    'Grooming',
    'Child Friendly',
    'HealthIssues',
    'Dog Friendly',
    'SheddingLevel'
  ];
  List<dynamic> targetValues1 = [];
  List<dynamic> targetValues2 = [];

  @override
  void initState() {
    super.initState();
    setTargetValues();
  }

  void setTargetValues() {
    print('--- ${breed2.toJson()}');
    //情感水平-适应性-能量水平-情报-发声-社会需求
    List<double> value1 = [
      breed1.affectionLevel?.toDouble() ?? 0,
      breed1.adaptability?.toDouble() ?? 0,
      breed1.energyLevel?.toDouble() ?? 0,
      breed1.intelligence?.toDouble() ?? 0,
      breed1.vocalisation?.toDouble() ?? 0,
      breed1.socialNeeds?.toDouble() ?? 0,
    ];
    List<double> value3 = [
      breed2.affectionLevel?.toDouble() ?? 0,
      breed2.adaptability?.toDouble() ?? 0,
      breed2.energyLevel?.toDouble() ?? 0,
      breed2.intelligence?.toDouble() ?? 0,
      breed2.vocalisation?.toDouble() ?? 0,
      breed2.socialNeeds?.toDouble() ?? 0,
    ];
    //陌生人友好-梳理-儿童友好型-健康问题-狗友-脱落水平
    List<double> value2 = [
      breed1.strangerFriendly?.toDouble() ?? 0,
      breed1.grooming?.toDouble() ?? 0,
      breed1.childFriendly?.toDouble() ?? 0,
      breed1.healthIssues?.toDouble() ?? 0,
      breed1.dogFriendly?.toDouble() ?? 0,
      breed1.sheddingLevel?.toDouble() ?? 0,
    ];
    List<double> value4 = [
      breed2.strangerFriendly?.toDouble() ?? 0,
      breed2.grooming?.toDouble() ?? 0,
      breed2.childFriendly?.toDouble() ?? 0,
      breed2.healthIssues?.toDouble() ?? 0,
      breed2.dogFriendly?.toDouble() ?? 0,
      breed2.sheddingLevel?.toDouble() ?? 0,
    ];
    targetValues1.add({
      'name': breed1.name,
      'value': value1,
      'color': Color.fromRGBO(232, 0, 84, 1),
    });
    targetValues1.add({
      'name': breed2.name,
      'value': value3,
      'color': Color.fromRGBO(80, 228, 255, 1),
    });
    targetValues2.add({
      'name': breed1.name,
      'value': value2,
      'color': Color.fromRGBO(232, 0, 84, 1),
    });
    targetValues2.add({
      'name': breed2.name,
      'value': value4,
      'color': Color.fromRGBO(80, 228, 255, 1),
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Positioned(
          left: 0,
          right: 0,
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: CacheImageWidget(
                                  height: 180,
                                  imageUrl:
                                      'https://cdn2.thecatapi.com/images/${breed1?.referenceImageId}.jpg'),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: CacheImageWidget(
                                  height: 180,
                                  imageUrl:
                                      'https://cdn2.thecatapi.com/images/${breed2?.referenceImageId}.jpg'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          'assets/images/icon_pk.png',
                          width: 50,
                          height: 50,
                        )),
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
                  ],
                ),
                Container(
                  child: Container(
                    child: RadarChartWidget(
                      name: 'character one',
                      targetNames: targetNames1,
                      targetValues: targetValues1,
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    child: RadarChartWidget(
                      name: 'character two',
                      targetNames: targetNames2,
                      targetValues: targetValues2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
