part of 'forecast_exception.dart';

class LocationNotFoundException implements ForecastException {
  @override
  final String message;
  @override
  final String mainMessage = 'No Results';
  final String cityName;

  LocationNotFoundException({required this.cityName})
      : message = 'No results found for "$cityName"';

  @override
  String toString() {
    return message;
  }
}
