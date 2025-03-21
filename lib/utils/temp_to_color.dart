import 'package:flutter/material.dart';

class TemperatureToGradientUtil {
  static Gradient getTempColor(int minTemp, int maxTemp) {
    return (20 >= minTemp && 20 <= maxTemp)
        ? LinearGradient(colors: [
            _getTempColor(minTemp),
            Colors.brown[100]!,
            _getTempColor(maxTemp),
          ])
        : LinearGradient(
            colors: [
              _getTempColor(minTemp),
              _getTempColor(maxTemp),
            ],
          );
  }

  static Color _getTempColor(int temp) {
    if (temp < 5) {
      return Colors.blue[600]!;
    } else if (temp < 10) {
      return Colors.blue[500]!;
    } else if (temp < 15) {
      return Colors.blue[400]!;
    } else if (temp < 20) {
      return Colors.brown[100]!;
    } else if (temp < 25) {
      return Colors.orange[400]!;
    } else if (temp < 30) {
      return Colors.orange[500]!;
    } else {
      return Colors.orange[600]!;
    }
  }
}
