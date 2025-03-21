import 'package:flutter/material.dart';
import 'package:weather_forcast/weather/view/widget/time_point.dart';

class ForecastTime extends StatelessWidget {
  const ForecastTime({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.isSelected,
  });

  final DateTime startTime;
  final DateTime endTime;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TimePoint(time: startTime),
        Icon(
          Icons.arrow_right_alt,
          color: isSelected ? Colors.black : Colors.grey[300],
          size: 16,
        ),
        TimePoint(time: endTime),
      ],
    );
  }
}
