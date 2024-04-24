import 'dart:convert';

class MultipleWinnersModel {
  final List<YearCountModel> years;

  MultipleWinnersModel({
    required this.years,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'years': years.map((x) => x.toMap()).toList()});

    return result;
  }

  factory MultipleWinnersModel.fromMap(Map<String, dynamic> map) {
    return MultipleWinnersModel(
      years: List<YearCountModel>.from(map['years']?.map((x) => YearCountModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MultipleWinnersModel.fromJson(String source) => MultipleWinnersModel.fromMap(json.decode(source));

  @override
  String toString() => 'MultipleWinnersModel(years: $years)';
}

class YearCountModel {
  final int year;
  final int winnerCount;

  YearCountModel({
    required this.year,
    required this.winnerCount,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'year': year});
    result.addAll({'winnerCount': winnerCount});

    return result;
  }

  factory YearCountModel.fromMap(Map<String, dynamic> map) {
    return YearCountModel(
      year: map['year']?.toInt() ?? 0,
      winnerCount: map['winnerCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory YearCountModel.fromJson(String source) => YearCountModel.fromMap(json.decode(source));

  @override
  String toString() => 'YearCountModel(year: $year, winnerCount: $winnerCount)';
}
