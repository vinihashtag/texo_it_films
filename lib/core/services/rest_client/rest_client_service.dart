import '../../../data/models/response_model.dart';

enum MethodRequest { get, post, put, patch, delete, download }

abstract class IRestClientService {
  Future<ResponseModel> request({
    required String path,
    MethodRequest method = MethodRequest.get,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    dynamic cancelToken,
    void Function(int, int)? updateProgress,
    void Function(int, int)? downloadProgress,
    String? savePath,
  });
}
