import 'package:get/get.dart';
import 'package:texo_it_films/modules/dashboard/dashboard_bindings.dart';
import 'package:texo_it_films/modules/dashboard/dashboard_page.dart';
import 'package:texo_it_films/modules/film/film_bindings.dart';
import 'package:texo_it_films/modules/film/film_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String dashboard = '/dashboard';
  static const String films = '/films';

  static final List<GetPage> pages = [
    GetPage(
      name: dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBindings(),
    ),
    GetPage(
      name: films,
      page: () => const FilmPage(),
      binding: FilmBindings(),
    ),
  ];
}
