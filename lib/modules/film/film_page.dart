import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/components/layout/layout_base.dart';
import './film_controller.dart';

class FilmPage extends GetView<FilmController> {
  const FilmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBase(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List movies',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
