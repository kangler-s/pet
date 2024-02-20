/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-14 09:09:53
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-17 21:04:46
 * @FilePath: /pet/lib/common/kRouters.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:get/get.dart';
import 'package:pet/common/photoScreen.dart';
import 'package:pet/pages/breedInfo.dart';
import 'package:pet/pages/breedcCompare.dart';
import 'package:pet/pages/home.dart';
import 'package:pet/pages/petInfo.dart';
import 'package:pet/pages/selectBreed.dart';

class Routers {
  static late String INITIAL = '/';
  static late String HOME = '/home';
  static late String PETINFO = '/petinfo';
  static late String BREEDINFO = '/breedinfo';
  static late String SELECTBREED = '/selectBreed';
  static late String BREEDCOMPARE = '/breedCompare';
  static late String PHOTOVIEW = '/photoview';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routers.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routers.PETINFO,
      page: () => PetInfoPage(),
    ),
    GetPage(
      name: Routers.BREEDINFO,
      page: () => BreedInfoPage(),
    ),
    GetPage(
      name: Routers.SELECTBREED,
      page: () => SelectBreedPage(),
    ),
    GetPage(
      name: Routers.BREEDCOMPARE,
      page: () => BreedComparePage(),
    ),
  ];
}
