part of 'forecast_exception.dart';

class NetworkException implements ForecastException {
  @override
  final String message =
      "The Forecast app isn't connected to the internet. To search, check your connection, then try again.";
  @override
  final String mainMessage = 'Search Unavailable';

  NetworkException();

  @override
  String toString() {
    return message;
  }
}
