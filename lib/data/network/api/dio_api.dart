import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_one_signal_app/data/network/api/api_service.dart';

import '../../../core/config/services/storage_utils.dart';
import '../../../core/config/utils/print_logger.dart';

class DioApi implements ApiService {
  final dio.Dio _dio;
  final StorageUtils _storageUtils;

  String _msg = 'Something went wrong';

  final _baseUrl = dotenv.env['BASE_URL'] ?? '';

  DioApi(this._dio, this._storageUtils) {
    setDioOptions();
  }

  // static String extractRefreshToken(String cookieString) {
  //   RegExp regExp = RegExp(r'refreshToken=([^;]+)');
  //   Match? match = regExp.firstMatch(cookieString);
  //   return match?.group(1) ?? '';
  // }

  @override
  setDioOptions() {
    final options = dio.BaseOptions(
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
    );
    _dio.options = options;
    _dio.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) async {
        String accessToken = _storageUtils.getToken();
        if (accessToken.isNotEmpty) {
          printLogger.message('access_token', accessToken);
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }

  @override
  Future<dynamic> getApi({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    printLogger.message('getApi', _baseUrl + path);
    try {
      final response = await _dio.get(
        _baseUrl + path,
        queryParameters: queryParameters,
        data: data,
      );
      printLogger.message('get response', response.data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return Future.error(response.statusMessage.toString());
      }
    } on dio.DioException catch (e) {
      String errorMessage = getError(e);
      return Future.error(errorMessage);
    } catch (e) {
      printLogger.error('get error2', e);
      return Future.error(_msg);
    }
  }

  @override
  Future<dynamic> postApi({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    printLogger.message('postApi', _baseUrl + path);
    try {
      final response = await _dio.post(
        _baseUrl + path,
        queryParameters: queryParameters,
        data: data,
      );
      printLogger.message('post response', response.data);
      if (response.statusCode == 200) {
        return Future.value(response.data);
      } else {
        return Future.error(response.statusMessage.toString());
      }
    } on dio.DioException catch (e) {
      printLogger.error('post error', e);
      String errorMessage = getError(e);
      return Future.error(errorMessage);
    } catch (e) {
      printLogger.error('post error2', e);
      return Future.error(e);
    }
  }

  @override
  Future<dynamic> putApi({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    printLogger.message('putApi', _baseUrl + path);
    try {
      final response = await _dio.put(
        _baseUrl + path,
        queryParameters: queryParameters,
        data: data,
      );
      printLogger.message('put response', response.data);
      if (response.statusCode == 200) {
        return Future.value(response.data);
      } else {
        return Future.error(response.statusMessage.toString());
      }
    } on dio.DioException catch (e) {
      printLogger.message('put error', e);
      String errorMessage = getError(e);
      return Future.error(errorMessage);
    } catch (e) {
      printLogger.message('put error2', e);
      return Future.error(_msg);
    }
  }

  @override
  Future<dynamic> deleteApi({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    printLogger.message('deleteApi', _baseUrl + path);
    try {
      final response = await _dio.delete(
        _baseUrl + path,
        queryParameters: queryParameters,
        data: data,
      );
      printLogger.message('delete response', response.data);
      if (response.statusCode == 200) {
        return Future.value(response.data);
      } else {
        return Future.error(response.statusMessage.toString());
      }
    } on dio.DioException catch (e) {
      printLogger.message('delete error', e);
      String errorMessage = getError(e);
      return Future.error(errorMessage);
    } catch (e) {
      printLogger.message('delete error2', e);
      return Future.error(_msg);
    }
  }

  @override
  String getError(DioException error) {
    printLogger.error(
      'dio exception',
      '${error.response?.realUri}: ${error.response?.data} => ${error.response?.statusCode}',
    );
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        _msg = 'Poor internet connection';
        break;
      case DioExceptionType.sendTimeout:
        _msg = 'Poor internet connection';
        break;
      case DioExceptionType.receiveTimeout:
        _msg = 'Poor internet connection';
        break;
      case DioExceptionType.connectionError:
        _msg = 'No internet connection';
        break;
      case DioExceptionType.badResponse:
        _msg = getBadResponseMessage(error.response);
        break;
      default:
        _msg = 'Something went wrong';
    }
    return _msg;
  }

  @override
  String getBadResponseMessage(Response? response) {
    switch (response?.statusCode) {
      case (502 || 500):
        return 'Server did not response. Try again later';
      default:
        try {
          Map<String, dynamic> data = response?.data as Map<String, dynamic>;
          return _msg = data['detail'];
        } catch (e) {
          return "Something went wrong";
        }
    }
  }
}
