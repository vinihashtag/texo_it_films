enum StatusTypeEnum {
  initial,
  loading,
  loadingMore,
  empty,
  generic,
  success,
  finished,
  error;

  bool get isInitial => this == StatusTypeEnum.initial;
  bool get isLoading => this == StatusTypeEnum.loading;
  bool get isLoadingMore => this == StatusTypeEnum.loadingMore;
  bool get isLoadingOrLoadingMore => isLoading || isLoadingMore;
  bool get isEmpty => this == StatusTypeEnum.empty;
  bool get isGeneric => this == StatusTypeEnum.generic;
  bool get isSuccess => this == StatusTypeEnum.success;
  bool get isFinished => this == StatusTypeEnum.finished;
  bool get isError => this == StatusTypeEnum.error;
}
