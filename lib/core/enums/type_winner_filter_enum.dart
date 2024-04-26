enum TypeWinnerFilterEnum {
  no,
  yes,
  yesNo;

  bool? get status => switch (this) {
        TypeWinnerFilterEnum.no => false,
        TypeWinnerFilterEnum.yes => true,
        TypeWinnerFilterEnum.yesNo => null,
      };

  String get text => switch (this) {
        TypeWinnerFilterEnum.no => 'No',
        TypeWinnerFilterEnum.yes => 'Yes',
        TypeWinnerFilterEnum.yesNo => 'Yes/No',
      };
}
