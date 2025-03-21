import 'package:weather_forcast/weather/core/weather_element.dart';
import 'package:weather_forcast/weather/domain/weather_element_value.dart';

class WeatherElementData {
  final WeatherElementEnum element;
  final WeatherElementValue weatherElementValue;

  WeatherElementData({
    required this.element,
    required this.weatherElementValue,
  });

  @override
  String toString() {
    return 'WeatherElementData{element: $element, weatherElementValue: $weatherElementValue}';
  }
}
