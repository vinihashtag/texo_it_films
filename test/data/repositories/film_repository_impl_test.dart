import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:texo_it_films/core/services/rest_client/rest_client_service.dart';
import 'package:texo_it_films/core/utils/erros.dart';
import 'package:texo_it_films/data/models/response_model.dart';
import 'package:texo_it_films/data/repositories/film_repository_impl.dart';
import 'package:texo_it_films/data/repositories/film_repository_interface.dart';

import '../../mocks/class_mocks.dart';
import '../../mocks/response_mocks.dart';

void main() {
  late IRestClientService restClientService;
  late IFilmRepository filmRepository;

  setUp(() {
    restClientService = RestClientServiceMock();
    filmRepository = FilmRepositoryImpl(restClientService);
  });

  group('[GET MULTIPLE WINNERS]', () {
    test('should returns model of multiple winners', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => ResponseModel(data: ResponseMocks.responseSucessGetMultipleWinners));

      //Act
      final response = await filmRepository.getMultipleWinners();

      //Assert
      expect(response.isSuccess, true);
      expect(response.data!.years.isNotEmpty, true);
    });

    test('should returns a exception when an error occurs in the API', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      //Act
      final response = await filmRepository.getMultipleWinners();

      //Assert
      expect(response.isError, true);
      expect(response.error is CustomException, true);
      expect((response.error as CustomException).exception is DioException, true);
    });
  });

  group('[GET TOP STUDIOS]', () {
    test('should returns model of top studios', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => ResponseModel(data: ResponseMocks.responseSucessGetStudiosWithCount));

      //Act
      final response = await filmRepository.getTopStudios();

      //Assert
      expect(response.isSuccess, true);
      expect(response.data!.studios.isNotEmpty, true);
    });

    test('should returns a exception when an error occurs in the API', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      //Act
      final response = await filmRepository.getTopStudios();

      //Assert
      expect(response.isError, true);
      expect(response.error is CustomException, true);
      expect((response.error as CustomException).exception is DioException, true);
    });
  });

  group('[GET MIN MAX PRODUCERS]', () {
    test('should returns min and max producers', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => ResponseModel(data: ResponseMocks.responseSucessGetMaxMinIntervalForProducers));

      //Act
      final response = await filmRepository.getMinMaxProducers();

      //Assert
      expect(response.isSuccess, true);
      expect(response.data!.min.isNotEmpty, true);
      expect(response.data!.max.isNotEmpty, true);
    });

    test('should returns a exception when an error occurs in the API', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      //Act
      final response = await filmRepository.getMinMaxProducers();

      //Assert
      expect(response.isError, true);
      expect(response.error is CustomException, true);
      expect((response.error as CustomException).exception is DioException, true);
    });
  });

  group('[GET WINNER BY YEAR]', () {
    test('should returns min and max producers', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => ResponseModel(data: ResponseMocks.responseSucessGetWinnersByYear));

      //Act
      final response = await filmRepository.getWinnersByYear(2018);

      //Assert
      expect(response.isSuccess, true);
      expect(response.data!.isNotEmpty, true);
    });

    test('should returns a exception when an error occurs in the API', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      //Act
      final response = await filmRepository.getMinMaxProducers();

      //Assert
      expect(response.isError, true);
      expect(response.error is CustomException, true);
      expect((response.error as CustomException).exception is DioException, true);
    });
  });

  group('[GET FILMS BY FILTER]', () {
    test('should returns a list of films by pagination', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => ResponseModel(data: ResponseMocks.responseSucessGetWinnersByYearPagination));

      //Act
      final response = await filmRepository.getFilmsByFilter(page: 1);

      //Assert
      expect(response.isSuccess, true);
      expect(response.data!.content.isNotEmpty, true);
    });

    test('should returns a exception when an error occurs in the API', () async {
      //Arrange
      when(() => restClientService.request(path: any(named: 'path'), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      //Act
      final response = await filmRepository.getFilmsByFilter(page: 1);

      //Assert
      expect(response.isError, true);
      expect(response.error is CustomException, true);
      expect((response.error as CustomException).exception is DioException, true);
    });
  });
}
