import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TitleDashboardWidget extends StatelessWidget {
  final String title;

  const TitleDashboardWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      minFontSize: 14,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
