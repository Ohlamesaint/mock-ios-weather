part 'location_not_found_exception.dart';
part 'network_exception.dart';

sealed class ForecastException implements Exception {
  final String message;
  final String mainMessage;

  ForecastException(this.message, this.mainMessage);
}
