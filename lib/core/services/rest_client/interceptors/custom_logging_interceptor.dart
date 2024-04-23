import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../utils/constants.dart';
import '../../../utils/custom_logger.dart';

class CustomLoggingInterceptor extends QueuedInterceptorsWrapper {
  final bool showCurl;
  final bool showResponseData;

  CustomLoggingInterceptor({this.showCurl = true, this.showResponseData = false});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerApp.debug('REQUEST:');
    LoggerApp.debug('${options.method} ${options.uri}');
    if (showCurl) LoggerApp.debug('CURL: ${_curlCommand(options)}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LoggerApp.info('RESPONSE:');
    LoggerApp.info('Status: ${response.statusCode}');
    if (showResponseData) LoggerApp.info('Headers: ${json.encode(response.headers.map)}');
    if (showResponseData) LoggerApp.info('Data: ${response.data != null ? json.encode(response.data) : 'null'}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error?.toString().contains(ConstantsApp.cancelledRequestApiByUser) ?? false) {
      return super.onError(err, handler);
    }

    LoggerApp.error('ERROR ON REQUEST:');
    LoggerApp.error('DioException ║ Status: ${err.response?.statusCode} ${err.response?.statusMessage}');
    LoggerApp.error('TYPE: ${err.type.toString()}');
    LoggerApp.error('Error: ${err.error}');
    LoggerApp.error('CURL: ${_curlCommand(err.requestOptions)}');

    super.onError(err, handler);
  }

  String _curlCommand(RequestOptions options) {
    String curl = 'curl -X ${options.method.toUpperCase()}';

    options.headers.forEach((key, value) => curl += ' -H \'$key: $value\'');

    if (options.data != null) {
      if (options.contentType != null && options.contentType!.contains('json')) {
        curl += " -d '${json.encode(options.data)}'";
      } else if (options.data is FormData) {
        FormData formData = options.data;
        for (var field in formData.fields) {
          curl += " -F '${field.key}=${field.value}'";
        }
      }
    }

    curl += ' ${options.uri}';

    return curl;
  }
}
