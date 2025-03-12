import 'package:dio/dio.dart';

/////////////App dio
class AppDioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      followRedirects: false,

      baseUrl: 'https://grad-app-back-end-v2.vercel.app/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'Authorization': token ?? '',
    };
    return dio.get(url);
  }

  static Future<Response> postImageData(
      {required String url,
      var image,
      Map<String, dynamic>? query,
      String? token,
      FormData? formData}) async {
    dio.options.headers = {
      'Authorization': token ?? '',
    };
    return dio.post(url, data: image, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token ?? '',
    };
    return dio.post(url, data: data, queryParameters: query);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",

      'Authorization': token ?? '',
    };
    return dio.put(url, data: data, queryParameters: query);
  }

  static Future<Response> deleteData({
    required String url,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token ?? '',
    };
    return dio.delete(url);
  }
}
