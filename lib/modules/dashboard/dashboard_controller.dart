import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:texo_it_films/core/enums/status_type_enum.dart';
import 'package:texo_it_films/data/repositories/film_repository_interface.dart';

import '../../data/models/min_max_producers_model.dart';
import '../../data/models/multiple_winners_model.dart';
import '../../data/models/top_studios_model.dart';
import '../../data/models/winner_by_year_model.dart';

class DashboardController extends GetxController {
  final IFilmRepository _filmRepository;

  DashboardController(this._filmRepository);

  // * Variables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls model of multiple winners
  MultipleWinnersModel? multipleWinnersModel;

  /// Controls model of top studios
  TopStudiosModel? topStudiosModel;

  /// Controls model of min max producers
  MinMaxProducersModel? minMaxProducersModel;

  /// Controls model of list of winner by year
  List<WinnerByYearModel> listWinnersByYear = [];

  // * Controllers
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  // * Observables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls status of card multi winners
  final Rx<StatusTypeEnum> _statusMultiWinners = Rx<StatusTypeEnum>(StatusTypeEnum.initial);
  StatusTypeEnum get statusWinners => _statusMultiWinners.value;

  /// Controls status of card Top studios
  final Rx<StatusTypeEnum> _statusTopStudios = Rx<StatusTypeEnum>(StatusTypeEnum.initial);
  StatusTypeEnum get statusTopStudios => _statusTopStudios.value;

  /// Controls status of card min max producers
  final Rx<StatusTypeEnum> _statusMinMaxProducers = Rx<StatusTypeEnum>(StatusTypeEnum.initial);
  StatusTypeEnum get statusMinMaxProducers => _statusMinMaxProducers.value;

  /// Controls status of card winners by year
  final Rx<StatusTypeEnum> _statusWinnersByYear = Rx<StatusTypeEnum>(StatusTypeEnum.initial);
  StatusTypeEnum get statusWinnersByYear => _statusWinnersByYear.value;

  /// Controls year to filter
  final Rxn<int> _yearSelected = Rxn<int>();
  int? get yearSelected => _yearSelected.value;
  set yearSelected(int? value) => _yearSelected.value = value;

  // * Actions
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  @override
  void onInit() {
    if (!GetPlatform.isDesktop) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    getMultipleWinners();
    getTopStudios();
    getMinMaxProducers();
    super.onInit();
  }

  Future<void> getMultipleWinners() async {
    _statusMultiWinners.value = StatusTypeEnum.loading;

    final response = await _filmRepository.getMultipleWinners();
    if (response.isError) {
      multipleWinnersModel = null;
      _statusMultiWinners.value = StatusTypeEnum.error;
    } else {
      multipleWinnersModel = response.data;
      _statusMultiWinners.value = StatusTypeEnum.success;
    }
  }

  Future<void> getTopStudios() async {
    _statusTopStudios.value = StatusTypeEnum.loading;

    final response = await _filmRepository.getTopStudios();
    if (response.isError) {
      topStudiosModel = null;
      _statusTopStudios.value = StatusTypeEnum.error;
    } else {
      topStudiosModel = response.data;
      _statusTopStudios.value = StatusTypeEnum.success;
    }
  }

  Future<void> getMinMaxProducers() async {
    _statusMinMaxProducers.value = StatusTypeEnum.loading;

    final response = await _filmRepository.getMinMaxProducers();
    if (response.isError) {
      minMaxProducersModel = null;
      _statusMinMaxProducers.value = StatusTypeEnum.error;
    } else {
      minMaxProducersModel = response.data;
      _statusMinMaxProducers.value = StatusTypeEnum.success;
    }
  }

  Future<void> getWinnersByYear(int year) async {
    _statusWinnersByYear.value = StatusTypeEnum.loading;

    listWinnersByYear.clear();
    final response = await _filmRepository.getWinnersByYear(year);
    if (response.isError) {
      minMaxProducersModel = null;
      _statusWinnersByYear.value = StatusTypeEnum.error;
    } else {
      listWinnersByYear.addAll(response.data ?? []);
      _statusWinnersByYear.value = StatusTypeEnum.success;
    }
  }
}
