import 'package:flutter/material.dart';
import 'package:weather_forcast/weather/domain/weather_element_data.dart'
    show WeatherElementData;

class ElementDataItem extends StatelessWidget {
  const ElementDataItem({
    super.key,
    required this.weatherElementData,
  });

  final WeatherElementData weatherElementData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weatherElementData.element.cht,
          style: TextStyle(color: Colors.grey[300]),
        ),
        Text(
          "${weatherElementData.weatherElementValue.name}",
          style: TextStyle(color: Colors.grey[300]),
        ),
      ],
    );
  }
}
