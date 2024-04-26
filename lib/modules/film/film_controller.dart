import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/enums/status_type_enum.dart';
import '../../core/enums/type_winner_filter_enum.dart';
import '../../data/models/film_pagination_model.dart';
import '../../data/repositories/film_repository_interface.dart';

class FilmController extends GetxController {
  final IFilmRepository _filmRepository;

  FilmController(this._filmRepository);

  // * Variables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls model of films pagination
  FilmPaginationModel? filmPaginationModel;

  /// Controls pagination
  int currentPage = -1;

  /// Controls range pagination
  int rangePagination = 15;

  /// Controls filter by year
  int? yearSelected;

  /// Controls range pagination
  TypeWinnerFilterEnum winnerFilter = TypeWinnerFilterEnum.yesNo;

  // * Observables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls status of page
  final Rx<StatusTypeEnum> _status = Rx<StatusTypeEnum>(StatusTypeEnum.initial);
  StatusTypeEnum get status => _status.value;

  /// Controls list of films
  final RxList<ContentModel> listFilms = RxList<ContentModel>();

  // * Getters
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  bool get hasMoreData => currentPage + 1 < filmPaginationModel!.totalPages - 1;

  int get twoPreviousPage => currentPage - 3 >= 0 ? currentPage - 3 : 0;

  int get twoNextPage =>
      filmPaginationModel!.totalPages > currentPage + 5 ? currentPage + 5 : filmPaginationModel!.totalPages;

  bool get hasFilter => yearSelected != null;

  // * Actions
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  @override
  void onInit() {
    if (!GetPlatform.isDesktop) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
    getFilmsByFilter(refresh: true);
    super.onInit();
  }

  Future<void> getFilmsByFilter({bool refresh = false, int? selectedPage}) async {
    _status.value = StatusTypeEnum.loading;

    if (refresh) {
      listFilms.clear();
      currentPage = -1;
    }

    if (selectedPage == null) {
      currentPage += 1;
    } else {
      currentPage = selectedPage;
    }

    final response = await _filmRepository.getFilmsByFilter(
      page: currentPage,
      size: rangePagination,
      winner: winnerFilter.status,
      year: yearSelected,
    );

    if (response.isError) {
      filmPaginationModel = null;
      _status.value = StatusTypeEnum.error;
    } else {
      filmPaginationModel = response.data;
      _status.value = StatusTypeEnum.success;
    }
  }

  @override
  void onClose() {
    if (!GetPlatform.isDesktop) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    super.onClose();
  }
}
