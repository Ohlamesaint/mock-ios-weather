import 'package:flutter/material.dart';

class TimePoint extends StatelessWidget {
  const TimePoint({super.key, required this.time});

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${time.day}",
            style: TextStyle(
                color: Colors.grey[300],
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          Text(
            "${time.hour.toString().padLeft(2, '0')}:00",
            style: TextStyle(color: Colors.grey[300]),
          ),
        ],
      ),
    );
  }
}
