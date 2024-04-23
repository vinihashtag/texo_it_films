import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texo_it_films/core/routes/routes.dart';
import 'package:texo_it_films/core/utils/custom_logger.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    LoggerApp.success(AppRoutes.dashboard == Get.currentRoute);
    return Drawer(
      backgroundColor: Colors.grey.shade100.withOpacity(0.5),
      shape: const BeveledRectangleBorder(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              minVerticalPadding: 0,
              onTap: () => Get.offAllNamed(AppRoutes.dashboard),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              title: const Text('Dashboard', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              selected: AppRoutes.dashboard == Get.currentRoute,
              selectedColor: const Color.fromARGB(255, 3, 71, 126),
            ),
            ListTile(
              dense: true,
              minVerticalPadding: 0,
              onTap: () => Get.offAllNamed(AppRoutes.films),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              title: const Text('List', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              selected: AppRoutes.films == Get.currentRoute,
              selectedColor: const Color.fromARGB(255, 3, 71, 126),
            ),
          ],
        ),
      ),
    );
  }
}
