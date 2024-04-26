import 'package:get/get.dart';
import 'package:texo_it_films/core/services/rest_client/rest_client_dio.dart';
import 'package:texo_it_films/core/services/rest_client/rest_client_service.dart';
import 'package:texo_it_films/data/repositories/film_repository_impl.dart';
import 'package:texo_it_films/data/repositories/film_repository_interface.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    // Adapters
    Get.put<IRestClientService>(RestClientServiceImpl(), permanent: true);

    // Repositories
    Get.put<IFilmRepository>(FilmRepositoryImpl(Get.find()), permanent: true);

    // Controllers
  }
}
