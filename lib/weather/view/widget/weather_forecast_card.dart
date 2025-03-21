import 'package:flutter/material.dart';
import 'package:weather_forcast/weather/core/weather_element.dart';
import 'package:weather_forcast/weather/domain/forecast_entity.dart';
import 'package:weather_forcast/weather/view/component/forecast_item.dart';
import 'package:weather_forcast/weather/view/widget/forecast_title.dart';

class WeatherForecastCard extends StatelessWidget {
  const WeatherForecastCard(
      {super.key,
      required this.forecastEntity,
      required this.title,
      required this.selectedForecastIndexNotifier,
      required this.onTap,
      cx});

  final ForecastEntity forecastEntity;
  final String title;
  final ValueNotifier<int> selectedForecastIndexNotifier;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey[800]!),
          ],
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ForecastTitle(title: title),
              ...forecastEntity.forecasts
                  .asMap()
                  .entries
                  .map<ValueListenableBuilder>(
                      (entry) => ValueListenableBuilder(
                          valueListenable: selectedForecastIndexNotifier,
                          builder: (context, _, __) {
                            return AnimatedOpacity(
                              opacity: entry.key ==
                                          selectedForecastIndexNotifier.value ||
                                      selectedForecastIndexNotifier.value == -1
                                  ? 1
                                  : 0.5,
                              duration: const Duration(milliseconds: 150),
                              child: entry.key ==
                                      selectedForecastIndexNotifier.value
                                  ? ForecastItem(
                                      forecast: entry.value,
                                      allMinTemp: allMinTemp,
                                      allMaxTemp: allMaxTemp,
                                      isSelected: true,
                                      onTap: () => onTap(entry.key),
                                      onUnSelect: () => onTap(-1),
                                    )
                                  : ForecastItem(
                                      forecast: entry.value,
                                      allMinTemp: allMinTemp,
                                      allMaxTemp: allMaxTemp,
                                      isSelected: false,
                                      onTap: () => onTap(entry.key),
                                      onUnSelect: () => onTap(-1),
                                    ),
                            );
                          })),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  int get allMinTemp => forecastEntity.forecasts
      .map((e) => e.weatherElementData
          .firstWhere((element) => element.element == WeatherElementEnum.minT))
      .map((element) => int.parse(element.weatherElementValue.name!))
      .reduce((value, element) => value < element ? value : element);

  int get allMaxTemp => forecastEntity.forecasts
      .map((e) => e.weatherElementData
          .firstWhere((element) => element.element == WeatherElementEnum.maxT))
      .map((element) => int.parse(element.weatherElementValue.name!))
      .reduce((value, element) => value > element ? value : element);
}
