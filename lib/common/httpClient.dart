/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-14 10:35:04
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-16 17:22:46
 * @FilePath: /pet/lib/common/httpClient.dart
 */

import 'package:dio/dio.dart';

String appkey =
    'live_S1jn8jjzorJxgjmQ0tccq5BLdjLuEjqggK2uIgN1bWUc6lysLXfA5WWVevAdaCUX';

class HttpClient {
  late Dio dio;
  static HttpClient instance = HttpClient._internal();

  ///工厂构造函数可以自定义实例的创建过程，并根据需要返回一个新的对象或现有的对象。
  factory HttpClient() {
    return instance;
  }

  HttpClient._internal() {
    print('构造函数。。。。。。。。。。。。。。');
    dio = Dio();
    dio.options.baseUrl = 'https://api.thecatapi.com';
    dio.options.headers = {'x-api-key': appkey};
    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.sendTimeout = const Duration(milliseconds: 10000);
    dio.interceptors.add(LogInterceptor(responseBody: true)); // 输出响应内容体
  }

  String getUrl(String url) {
    if (url.contains('/v2/')) {
      url = 'https://geoapi.qweather.com' + url;
    } else {
      url = 'https://devapi.qweather.com' + url;
    }
    return url;
  }

  /// get请求
  Future<Response?> get(String url, {Map<String, dynamic>? map}) async {
    try {
      var result = await dio.get(url, queryParameters: map);
      return result;
    } catch (e) {
      print('HttManager get e $e }');
      return null;
    }
  }

  ///post请求
  Future<Response?> post(String url, Map<String, dynamic>? map) async {
    try {
      var result = await dio.post(url, data: map);
      return result;
    } catch (e) {
      print('HttManager post e $e }');
      return null;
    }
  }

  ///上传文件 fileName 文件名字 fileDir 文件路径  formData 自定义参数
  Future<Response?> uploadFile(String url, String? fileName, String fileDir,
      Map<String, dynamic> formData) async {
    try {
      formData['file'] =
          await MultipartFile.fromFile(fileDir, filename: fileName);
      var response = await dio.post(url, data: formData);
      print(response.data);
      return response;
    } catch (e) {
      return null;
    }
  }
}
