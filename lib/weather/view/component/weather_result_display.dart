import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forcast/weather/core/exception/forecast_exception.dart';
import 'package:weather_forcast/weather/core/weather_element.dart';
import 'package:weather_forcast/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_forcast/weather/view/widget/element_data_item.dart';
import 'package:weather_forcast/weather/view/widget/error_display.dart';
import 'package:weather_forcast/weather/view/widget/weather_forecast_card.dart';

class WeatherResultDisplay extends HookConsumerWidget {
  const WeatherResultDisplay({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsyncValue = ref.watch(weatherProvider(location));
    final selectedForecast = useValueNotifier(-1);

    return weatherAsyncValue.when(
        data: (forecastEntity) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                forecastEntity.cityName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48),
              ),
              WeatherForecastCard(
                selectedForecastIndexNotifier: selectedForecast,
                title: forecastEntity.description,
                forecastEntity: forecastEntity,
                onTap: (int index) {
                  selectedForecast.value = index;
                },
              ),
              ValueListenableBuilder(
                  valueListenable: selectedForecast,
                  builder: (context, selectedIndex, _) {
                    if (selectedForecast.value < 0) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        children: forecastEntity
                            .forecasts[selectedIndex].weatherElementData
                            .where((elementData) =>
                                elementData.element !=
                                    WeatherElementEnum.minT &&
                                elementData.element != WeatherElementEnum.maxT)
                            .map((elementData) => ElementDataItem(
                                  weatherElementData: elementData,
                                ))
                            .toList(),
                      ),
                    );
                  })
            ],
          );
        },
        loading: () => SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        error: (error, stackTrace) {
          switch (error) {
            case NetworkException _:
              return ErrorDisplay(
                message: error.message,
                mainMessage: error.mainMessage,
                icon: Icons.wifi_off_rounded,
              );
            case LocationNotFoundException _:
              return ErrorDisplay(
                message: error.message,
                mainMessage: error.mainMessage,
                icon: Icons.location_off_rounded,
              );
            default:
              return const ErrorDisplay(
                message: 'An error occurred, please try again later.',
                mainMessage: 'Oops!',
                icon: Icons.error_outline_rounded,
              );
          }
        });
  }
}
