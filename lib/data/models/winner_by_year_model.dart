import 'dart:convert';

class WinnerByYearModel {
  final int id;
  final int year;
  final String title;
  final List<String> studios;
  final List<String> producers;
  final bool winner;

  WinnerByYearModel({
    required this.id,
    required this.year,
    required this.title,
    required this.studios,
    required this.producers,
    required this.winner,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'year': year});
    result.addAll({'title': title});
    result.addAll({'studios': studios});
    result.addAll({'producers': producers});
    result.addAll({'winner': winner});

    return result;
  }

  factory WinnerByYearModel.fromMap(Map<String, dynamic> map) {
    return WinnerByYearModel(
      id: map['id']?.toInt() ?? 0,
      year: map['year']?.toInt() ?? 0,
      title: map['title'] ?? '',
      studios: List<String>.from(map['studios']),
      producers: List<String>.from(map['producers']),
      winner: map['winner'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory WinnerByYearModel.fromJson(String source) => WinnerByYearModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WinnerByYearModel(id: $id, year: $year, title: $title, studios: $studios, producers: $producers, winner: $winner)';
  }
}
