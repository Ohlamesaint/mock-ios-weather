import 'package:flutter/material.dart';
import 'package:weather_forcast/utils/temp_to_color.dart';

class MinMaxTempBar extends StatelessWidget {
  const MinMaxTempBar({
    super.key,
    required this.minTemp,
    required this.maxTemp,
    required this.allMinTemp,
    required this.allMaxTemp,
    required this.isSelected,
  });

  final int minTemp;
  final int maxTemp;
  final int allMinTemp;
  final int allMaxTemp;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30,
          alignment: Alignment.center,
          child: Text(
            "$minTemp",
            style:
                TextStyle(color: isSelected ? Colors.black : Colors.grey[300]),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 5,
                ),
                Positioned(
                  left: (minTemp - allMinTemp) /
                      (allMaxTemp - allMinTemp) *
                      constraints.maxWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: TemperatureToGradientUtil.getTempColor(
                          minTemp, maxTemp),
                    ),
                    height: 5,
                    width: (maxTemp - minTemp) /
                        (allMaxTemp - allMinTemp) *
                        constraints.maxWidth,
                  ),
                ),
              ],
            );
          }),
        ),
        const SizedBox(width: 5),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: Text(
            "$maxTemp",
            style:
                TextStyle(color: isSelected ? Colors.black : Colors.grey[300]),
          ),
        ),
      ],
    );
  }
}
