import 'package:dio/dio.dart';

class DioHelper {
  static  Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
     String? url,
     Map<String, dynamic>? query,
  }) async {
    try {
      return await dio!.get(url!, queryParameters: query);
    } on DioError catch (e) {
      return Response(
        requestOptions: e.requestOptions,
        statusCode: e.response?.statusCode,
        statusMessage: e.response?.statusMessage,
        data: e.response?.data,
      );
    }
  }
}
