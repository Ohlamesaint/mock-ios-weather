import 'package:weather_forcast/weather/domain/weather_element_data.dart';

class Forecast {
  final DateTime startTime;
  final DateTime endTime;
  final List<WeatherElementData> weatherElementData;

  Forecast({
    required this.startTime,
    required this.endTime,
    required this.weatherElementData,
  });

  bool sameTime(DateTime startTime, DateTime endTime) {
    return this.startTime == startTime && this.endTime == endTime;
  }

  @override
  String toString() {
    return 'Forecast{startTime: $startTime, endTime: $endTime, weatherElementData: $weatherElementData}';
  }
}
