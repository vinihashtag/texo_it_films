import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texo_it_films/core/routes/routes.dart';
import 'package:texo_it_films/core/theme/app_theme.dart';
import 'package:texo_it_films/main_bindings.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/utils/custom_logger.dart';
import 'core/utils/custom_responsive.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Texo IT - Films',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      initialRoute: AppRoutes.dashboard,
      getPages: AppRoutes.pages,
      defaultTransition: Transition.fadeIn,
      initialBinding: MainBinding(),
      builder: (context, child) {
        child = MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );

        CustomResponsive.size = MediaQuery.of(context).size;

        LoggerApp.success('CHANGED SIZE APP: width:${CustomResponsive.width} and height: ${CustomResponsive.height}');

        return child;
      },
    );
  }
}
