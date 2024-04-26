import 'package:flutter/material.dart';

class LoadingDashboardWidget extends StatelessWidget {
  final double? height;
  const LoadingDashboardWidget({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
