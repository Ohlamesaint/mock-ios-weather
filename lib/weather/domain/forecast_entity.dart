import 'package:weather_forcast/weather/domain/weather_entity.dart';

class ForecastEntity {
  final String cityName;
  final String description;
  final List<Forecast> forecasts;

  ForecastEntity({
    required this.cityName,
    required this.forecasts,
    required this.description,
  });

  @override
  String toString() {
    return 'ForecastEntity{cityName: $cityName, description: $description, forecasts: $forecasts}';
  }
}
