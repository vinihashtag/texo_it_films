import 'package:texo_it_films/core/enums/type_request_enum.dart';

import '../../../data/models/response_model.dart';

abstract class IRestClientService {
  Future<ResponseModel> request({
    required String path,
    TypeRequestEnum method = TypeRequestEnum.get,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    dynamic cancelToken,
    void Function(int, int)? updateProgress,
    void Function(int, int)? downloadProgress,
    String? savePath,
  });
}
