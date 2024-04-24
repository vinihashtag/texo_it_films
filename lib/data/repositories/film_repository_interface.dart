import 'package:texo_it_films/core/utils/erros.dart';
import 'package:texo_it_films/data/models/min_max_producers_model.dart';
import 'package:texo_it_films/data/models/multiple_winners_model.dart';
import 'package:texo_it_films/data/models/response_model.dart';
import 'package:texo_it_films/data/models/winner_by_year_model.dart';

import '../models/film_pagination_model.dart';
import '../models/top_studios_model.dart';

abstract class IFilmRepository {
  Future<ResponseModel<MultipleWinnersModel, CustomException>> getMultipleWinners();
  Future<ResponseModel<TopStudiosModel, CustomException>> getTopStudios();
  Future<ResponseModel<MinMaxProducersModel, CustomException>> getMinMaxProducers();
  Future<ResponseModel<List<WinnerByYearModel>, CustomException>> getWinnersByYear(int year);
  Future<ResponseModel<FilmPaginationModel, CustomException>> getFilmsByFilter(
      {required int page, int? year, bool winner = false});
}
