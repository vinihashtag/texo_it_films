import 'dart:convert';

class MinMaxProducersModel {
  final List<MinMaxModel> min;
  final List<MinMaxModel> max;

  MinMaxProducersModel({
    required this.min,
    required this.max,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'min': min.map((x) => x.toMap()).toList()});
    result.addAll({'max': max.map((x) => x.toMap()).toList()});

    return result;
  }

  factory MinMaxProducersModel.fromMap(Map<String, dynamic> map) {
    return MinMaxProducersModel(
      min: List<MinMaxModel>.from(map['min']?.map((x) => MinMaxModel.fromMap(x))),
      max: List<MinMaxModel>.from(map['max']?.map((x) => MinMaxModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MinMaxProducersModel.fromJson(String source) => MinMaxProducersModel.fromMap(json.decode(source));

  @override
  String toString() => 'MinMaxProducersModel(min: $min, max: $max)';
}

class MinMaxModel {
  final String producer;
  final int interval;
  final int previousWin;
  final int followingWin;

  MinMaxModel({
    required this.producer,
    required this.interval,
    required this.previousWin,
    required this.followingWin,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'producer': producer});
    result.addAll({'interval': interval});
    result.addAll({'previousWin': previousWin});
    result.addAll({'followingWin': followingWin});

    return result;
  }

  factory MinMaxModel.fromMap(Map<String, dynamic> map) {
    return MinMaxModel(
      producer: map['producer'] ?? '',
      interval: map['interval']?.toInt() ?? 0,
      previousWin: map['previousWin']?.toInt() ?? 0,
      followingWin: map['followingWin']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MinMaxModel.fromJson(String source) => MinMaxModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MinMaxModel(producer: $producer, interval: $interval, previousWin: $previousWin, followingWin: $followingWin)';
  }
}
