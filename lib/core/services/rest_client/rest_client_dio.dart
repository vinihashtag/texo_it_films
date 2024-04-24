import 'package:dio/dio.dart';
import 'package:texo_it_films/core/utils/constants.dart';
import 'package:texo_it_films/core/utils/custom_logger.dart';

import '../../../data/models/response_model.dart';
import '../../enums/type_request_enum.dart';
import '../../utils/erros.dart';
import 'interceptors/custom_logging_interceptor.dart';
import 'rest_client_service.dart';

class RestClientServiceImpl implements IRestClientService {
  late Dio _dio;

  RestClientServiceImpl() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        baseUrl: ConstantsApp.baseUrl,
      ),
    );
  }

  @override
  Future<ResponseModel> request({
    required String path,
    TypeRequestEnum method = TypeRequestEnum.get,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    cancelToken,
    void Function(int p1, int p2)? updateProgress,
    void Function(int p1, int p2)? downloadProgress,
    String? savePath,
  }) async {
    final defaultHeaders = headers ?? {};

    _dio.interceptors.clear();

    try {
      _dio.interceptors.add(CustomLoggingInterceptor());

      final Response response = await _dio.request(
        /// If the `path` starts with 'http(s)', the `baseURL` will be ignored, otherwise,
        /// it will be combined and then resolved with the baseUrl.
        path,
        data: data,
        options: Options(headers: defaultHeaders, method: method.name.toUpperCase()),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: downloadProgress,
      );

      return ResponseModel(data: response.data);
    } on DioException catch (e) {
      return ResponseModel(
          error: DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            type: e.type,
            error: e.error,
          ),
          statusCode: e.response?.statusCode);
    } catch (e, s) {
      LoggerApp.error('Error on request:', e, s);
      return ResponseModel(error: UnexpectedException(exception: e, stackTrace: s), statusCode: 500);
    }
  }
}
