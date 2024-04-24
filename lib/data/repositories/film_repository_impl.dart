import 'package:texo_it_films/core/services/rest_client/rest_client_service.dart';
import 'package:texo_it_films/core/utils/custom_logger.dart';
import 'package:texo_it_films/data/models/min_max_producers_model.dart';
import 'package:texo_it_films/data/models/response_model.dart';
import 'package:texo_it_films/data/models/top_studios_model.dart';
import 'package:texo_it_films/data/models/winner_by_year_model.dart';
import 'package:texo_it_films/data/repositories/film_repository_interface.dart';

import '../../core/utils/erros.dart';
import '../models/film_pagination_model.dart';
import '../models/multiple_winners_model.dart';

class FilmRepositoryImpl implements IFilmRepository {
  final IRestClientService _restClientService;

  FilmRepositoryImpl(this._restClientService);

  @override
  Future<ResponseModel<MultipleWinnersModel, CustomException>> getMultipleWinners() async {
    try {
      final response = await _restClientService.request(
        path: '',
        queryParameters: {'projection': 'years-with-multiple-winners'},
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: MultipleWinnersModel.fromMap(response.data));
    } catch (e, s) {
      LoggerApp.error('Error on get multiple winners', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get multiple winners',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<ResponseModel<TopStudiosModel, CustomException>> getTopStudios() async {
    try {
      final response = await _restClientService.request(
        path: '',
        queryParameters: {'projection': 'studios-with-win-count'},
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: TopStudiosModel.fromMap(response.data));
    } catch (e, s) {
      LoggerApp.error('Error on get top studios', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get top studios',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<ResponseModel<MinMaxProducersModel, CustomException>> getMinMaxProducers() async {
    try {
      final response = await _restClientService.request(
        path: '',
        queryParameters: {'projection': 'max-min-win-interval-for-producers'},
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: MinMaxProducersModel.fromMap(response.data));
    } catch (e, s) {
      LoggerApp.error('Error on get min max producers', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get min max producers',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<ResponseModel<List<WinnerByYearModel>, CustomException>> getWinnersByYear(int year) async {
    try {
      final response = await _restClientService.request(
        path: '',
        queryParameters: {'winner': true, 'year': year},
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: (response.data as List).map((e) => WinnerByYearModel.fromMap(e)).toList());
    } catch (e, s) {
      LoggerApp.error('Error on get winners by year', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get winners by year',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<ResponseModel<FilmPaginationModel, CustomException>> getFilmsByFilter(
      {required int page, int? year, bool winner = false}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'page': page,
        'size': 99,
        if (year != null) 'year': year,
        if (winner) 'winner': true,
      };

      final response = await _restClientService.request(
        path: '',
        queryParameters: queryParameters,
      );

      if (response.isError) return ResponseModel(error: response.error);

      return ResponseModel(data: FilmPaginationModel.fromMap(response.data));
    } catch (e, s) {
      LoggerApp.error('Error on get winners by year', e, s);
      return ResponseModel(
        error: CustomException(
          message: 'Error on get winners by year',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }
}
