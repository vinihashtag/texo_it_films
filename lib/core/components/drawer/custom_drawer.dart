import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texo_it_films/core/routes/routes.dart';

class CustomDrawer extends StatelessWidget {
  final double width;
  const CustomDrawer({super.key, this.width = 250});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade100,
      surfaceTintColor: Colors.white,
      shape: const BeveledRectangleBorder(),
      width: width,
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
