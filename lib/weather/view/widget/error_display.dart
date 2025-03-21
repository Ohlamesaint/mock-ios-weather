import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    super.key,
    required this.icon,
    required this.message,
    required this.mainMessage,
  });

  final IconData icon;
  final String message;
  final String mainMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.grey[500],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            mainMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
