import 'dart:collection';

import 'package:weather_forcast/weather/core/weather_element.dart';
import 'package:weather_forcast/weather/data/model/weather_model.dart';
import 'package:weather_forcast/weather/domain/forecast_entity.dart';
import 'package:weather_forcast/weather/domain/weather_element_value.dart';
import 'package:weather_forcast/weather/domain/weather_entity.dart';
import 'package:weather_forcast/weather/domain/weather_element_data.dart';

class WeatherModelToForecastEntityMapper {
  static ForecastEntity map(WeatherModel weatherModel) {
    final location = weatherModel.records?.location?[0];
    final SplayTreeMap<DateTime, Forecast> startDateTime2Forecast =
        SplayTreeMap<DateTime, Forecast>();
    location?.weatherElement?.forEach((element) {
      final elementEnum = WeatherElementEnum.fromEng(element.elementName ?? "");
      element.time?.forEach((time) {
        startDateTime2Forecast
            .putIfAbsent(
              time.startTime!,
              () => Forecast(
                startTime: time.startTime!,
                endTime: time.endTime!,
                weatherElementData: [],
              ),
            )
            .weatherElementData
            .add(
              WeatherElementData(
                element: elementEnum,
                weatherElementValue: WeatherElementValue(
                  name: time.parameter?.parameterName,
                  value: time.parameter?.parameterValue,
                  unit: time.parameter?.parameterUnit,
                ),
              ),
            );
      });
    });

    final result = ForecastEntity(
        cityName: location!.locationName!,
        forecasts: [],
        description: weatherModel.records?.datasetDescription ?? "");
    result.forecasts.addAll(startDateTime2Forecast.values);
    return result;
  }
}
