import 'package:flutter/material.dart';

class ErrorDashboardWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const ErrorDashboardWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.error_outline, color: Colors.grey, size: 80),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Erro ao obter dados', textAlign: TextAlign.center),
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('TENTE NOVAMENTE', textAlign: TextAlign.center),
        )
      ],
    );
  }
}
