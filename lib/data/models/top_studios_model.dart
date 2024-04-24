import 'dart:convert';

class TopStudiosModel {
  final List<StudioModel> studios;

  TopStudiosModel({
    required this.studios,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'studios': studios.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TopStudiosModel.fromMap(Map<String, dynamic> map) {
    return TopStudiosModel(
      studios: List<StudioModel>.from(map['studios']?.map((x) => StudioModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TopStudiosModel.fromJson(String source) => TopStudiosModel.fromMap(json.decode(source));

  @override
  String toString() => 'TopStudiosModel(studios: $studios)';
}

class StudioModel {
  final String name;
  final int winCount;

  StudioModel({
    required this.name,
    required this.winCount,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'winCount': winCount});

    return result;
  }

  factory StudioModel.fromMap(Map<String, dynamic> map) {
    return StudioModel(
      name: map['name'] ?? '',
      winCount: map['winCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudioModel.fromJson(String source) => StudioModel.fromMap(json.decode(source));

  @override
  String toString() => 'StudioModel(name: $name, winCount: $winCount)';
}
