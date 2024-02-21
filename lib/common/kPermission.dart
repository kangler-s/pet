/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-19 21:55:18
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-19 22:20:37
 * @FilePath: /pet/lib/common/kPermission.dart
 */
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pet/common/httpClient.dart';

class KPermission {
  // 授予权限返回true， 否则返回false
  static Future requestScopePermission(Permission scope) async {
    // 获取当前的权限
    PermissionStatus status = await scope.status;
    if (status == PermissionStatus.granted) {
      // 已经授权
      return true;
    } else {
      // 未授权则发起一次申请
      status = await scope.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  //保存图片
  // 异步函数，用于保存网络图片到相册
  static Future<void> _saveImage(String imageUrl) async {
    try {
      // 创建Dio实例
      Dio dio = Dio();
      // 发起GET请求获取图片数据，指定响应类型为字节流
      Response response = await dio.get(imageUrl,
          options: Options(responseType: ResponseType.bytes));
      // 将响应数据转换为Uint8List类型的图片数据
      Uint8List imageData = Uint8List.fromList(response.data);
      // 调用ImageGallerySaver保存图片到相册，指定图片质量为60
      final result = await ImageGallerySaver.saveImage(imageData, quality: 60);
      // 返回保存结果
      return result;
    } catch (e) {
      // 捕获并打印保存图片过程中的错误
      print('保存图片出错: $e');
    }
  }

  static Future saveToAlbum(List imageUrls) async {
    // 获取相册权限
    bool storageStatus = await requestScopePermission(Permission.storage);
    if (storageStatus) {
      Map curRes = {'index': 0, 'isSuccess': false};
      EasyLoading.showToast('正在保存');
      for (int i = 0; i < imageUrls.length; i++) {
        var result = await _saveImage(imageUrls[i]);
        curRes['index'] = i;
        // curRes['isSuccess'] = result['isSuccess'];
      }
      if (curRes['index'] == imageUrls.length - 1) {
        EasyLoading.showSuccess('保存成功');
      }
    } else {
      EasyLoading.showError('暂无相册授权');
    }
  }
}
