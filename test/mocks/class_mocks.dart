import 'package:mocktail/mocktail.dart';
import 'package:texo_it_films/core/services/rest_client/rest_client_service.dart';
import 'package:texo_it_films/data/repositories/film_repository_interface.dart';

class RestClientServiceMock extends Mock implements IRestClientService {}

class FilmRepositoryMock extends Mock implements IFilmRepository {}
