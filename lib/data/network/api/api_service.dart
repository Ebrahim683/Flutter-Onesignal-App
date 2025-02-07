import 'package:dio/dio.dart';

abstract class ApiService {
  void setDioOptions();

  Future<dynamic> getApi({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> postApi({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  });

  Future<dynamic> putApi({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  });

  Future<dynamic> deleteApi({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  });

  String getError(DioException error);

  String getBadResponseMessage(Response? response);
}
