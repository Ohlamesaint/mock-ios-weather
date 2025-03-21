import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_forcast/constant/constant.dart';
import 'package:weather_forcast/utils/http_utils.dart';
import 'package:weather_forcast/weather/core/exception/forecast_exception.dart';
import 'package:weather_forcast/weather/data/mapper/mapper.dart';
import 'package:weather_forcast/weather/data/model/weather_model.dart';
import 'package:weather_forcast/weather/domain/forecast_entity.dart';

final weatherProvider =
    FutureProviderFamily<ForecastEntity, String>((ref, cityName) async {
  await Future.delayed(const Duration(seconds: 1));
  WeatherRepositoryImpl weatherRepository = WeatherRepositoryImpl();
  return await weatherRepository.fetchWeather(cityName);
});

abstract class WeatherRepository {
  Future<void> fetchWeather(String cityName);
}

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl();

  @override
  Future<ForecastEntity> fetchWeather(String cityName) async {
    await Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult[0] == ConnectivityResult.none) {
        throw NetworkException();
      }
    });

    try {
      final queryParameters = <String, String>{
        'Authorization': Constant.apiKey,
        'format': 'json',
        'locationName': cityName,
      };

      final response = await HttpUtils.httpGet<dynamic>(
          url: Constant.baseUrl, queries: queryParameters);
      if (response.data == null) {
        return throw LocationNotFoundException(cityName: cityName);
      } else {
        debugPrint(response.data!.toString());
        final weatherModel =
            WeatherModel.fromJson(response.data! as Map<String, dynamic>);

        final result = WeatherModelToForecastEntityMapper.map(weatherModel);
        debugPrint("result: $result");
        return result;
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw LocationNotFoundException(cityName: cityName);
    }
  }
}
