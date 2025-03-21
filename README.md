# weather_forecast
This is a simple weather forecast app that uses the Open Weather Data API to get the weather forecast for a given city.

## Flutter version
- Flutter 3.29.2
- Dart 3.7.2

## How to Run
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to run the app

## Internals
### State Management
- flutter_hook
- riverpod (for dependency injection)

### API 
- Open Weather Data API
  - 一般天氣預報-今明 36 小時天氣預報

### Error Handling
- Network Error
  - No Internet Connection
- Location Not Found Error
  - Location Not Found
