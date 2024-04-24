import 'dart:convert';

class FilmPaginationModel {
  final List<ContentModel> content;
  final PageableModel pageable;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int size;
  final int number;
  final SortModel sort;
  final bool first;
  final int numberOfElements;
  final bool empty;

  FilmPaginationModel({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'content': content.map((x) => x.toMap()).toList()});
    result.addAll({'pageable': pageable.toMap()});
    result.addAll({'totalPages': totalPages});
    result.addAll({'totalElements': totalElements});
    result.addAll({'last': last});
    result.addAll({'size': size});
    result.addAll({'number': number});
    result.addAll({'sort': sort.toMap()});
    result.addAll({'first': first});
    result.addAll({'numberOfElements': numberOfElements});
    result.addAll({'empty': empty});

    return result;
  }

  factory FilmPaginationModel.fromMap(Map<String, dynamic> map) {
    return FilmPaginationModel(
      content: List<ContentModel>.from(map['content']?.map((x) => ContentModel.fromMap(x))),
      pageable: PageableModel.fromMap(map['pageable']),
      totalPages: map['totalPages']?.toInt() ?? 0,
      totalElements: map['totalElements']?.toInt() ?? 0,
      last: map['last'] ?? false,
      size: map['size']?.toInt() ?? 0,
      number: map['number']?.toInt() ?? 0,
      sort: SortModel.fromMap(map['sort']),
      first: map['first'] ?? false,
      numberOfElements: map['numberOfElements']?.toInt() ?? 0,
      empty: map['empty'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilmPaginationModel.fromJson(String source) => FilmPaginationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FilmPaginationModel(content: $content, pageable: $pageable, totalPages: $totalPages, totalElements: $totalElements, last: $last, size: $size, number: $number, sort: $sort, first: $first, numberOfElements: $numberOfElements, empty: $empty)';
  }
}

class ContentModel {
  final int id;
  final int year;
  final String title;
  final List<String> studios;
  final List<String> producers;
  final bool winner;

  ContentModel({
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

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      id: map['id']?.toInt() ?? 0,
      year: map['year']?.toInt() ?? 0,
      title: map['title'] ?? '',
      studios: List<String>.from(map['studios']),
      producers: List<String>.from(map['producers']),
      winner: map['winner'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContentModel.fromJson(String source) => ContentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContentModel(id: $id, year: $year, title: $title, studios: $studios, producers: $producers, winner: $winner)';
  }
}

class PageableModel {
  final SortModel sort;
  final int offset;
  final int pageSize;
  final int pageNumber;
  final bool paged;
  final bool unpaged;

  PageableModel({
    required this.sort,
    required this.offset,
    required this.pageSize,
    required this.pageNumber,
    required this.paged,
    required this.unpaged,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'sort': sort.toMap()});
    result.addAll({'offset': offset});
    result.addAll({'pageSize': pageSize});
    result.addAll({'pageNumber': pageNumber});
    result.addAll({'paged': paged});
    result.addAll({'unpaged': unpaged});

    return result;
  }

  factory PageableModel.fromMap(Map<String, dynamic> map) {
    return PageableModel(
      sort: SortModel.fromMap(map['sort']),
      offset: map['offset']?.toInt() ?? 0,
      pageSize: map['pageSize']?.toInt() ?? 0,
      pageNumber: map['pageNumber']?.toInt() ?? 0,
      paged: map['paged'] ?? false,
      unpaged: map['unpaged'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PageableModel.fromJson(String source) => PageableModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PageableModel(sort: $sort, offset: $offset, pageSize: $pageSize, pageNumber: $pageNumber, paged: $paged, unpaged: $unpaged)';
  }
}

class SortModel {
  final bool unsorted;
  final bool sorted;
  final bool empty;

  SortModel({
    required this.unsorted,
    required this.sorted,
    required this.empty,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'unsorted': unsorted});
    result.addAll({'sorted': sorted});
    result.addAll({'empty': empty});

    return result;
  }

  factory SortModel.fromMap(Map<String, dynamic> map) {
    return SortModel(
      unsorted: map['unsorted'] ?? false,
      sorted: map['sorted'] ?? false,
      empty: map['empty'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SortModel.fromJson(String source) => SortModel.fromMap(json.decode(source));

  @override
  String toString() => 'SortModel(unsorted: $unsorted, sorted: $sorted, empty: $empty)';
}
