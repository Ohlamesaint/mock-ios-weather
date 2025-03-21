import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_forcast/weather/core/weather_element.dart';
import 'package:weather_forcast/weather/domain/weather_entity.dart';
import 'package:weather_forcast/weather/view/widget/forecast_time.dart';
import 'package:weather_forcast/weather/view/widget/min_max_temp_bar.dart';

class ForecastItem extends StatelessWidget {
  const ForecastItem({
    super.key,
    required this.forecast,
    required this.allMinTemp,
    required this.allMaxTemp,
    required this.isSelected,
    required this.onTap,
    required this.onUnSelect,
  });

  final Forecast forecast;
  final int allMinTemp;
  final int allMaxTemp;
  final bool isSelected;
  final Function onTap;
  final Function onUnSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Material(
        elevation: isSelected ? 30 : 0,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        animationDuration: const Duration(milliseconds: 150),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.white70 : Colors.transparent,
              width: 1,
            ),
            color: isSelected ? Colors.white70 : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ForecastTime(
                        isSelected: isSelected,
                        startTime: forecast.startTime,
                        endTime: forecast.endTime),
                    const SizedBox(width: 5),
                    Expanded(
                      child: MinMaxTempBar(
                        isSelected: isSelected,
                        minTemp: int.parse(forecast.weatherElementData
                            .firstWhere((element) =>
                                element.element == WeatherElementEnum.minT)
                            .weatherElementValue
                            .name!),
                        maxTemp: int.parse(forecast.weatherElementData
                            .firstWhere((element) =>
                                element.element == WeatherElementEnum.maxT)
                            .weatherElementValue
                            .name!),
                        allMinTemp: allMinTemp,
                        allMaxTemp: allMaxTemp,
                      ),
                    )
                  ],
                ),
                if (isSelected)
                  Positioned(
                      top: -10,
                      right: 5,
                      child: GestureDetector(
                        onTap: () => onUnSelect(),
                        child: OverflowBox(
                          maxHeight: 20,
                          fit: OverflowBoxFit.deferToChild,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[900]!.withAlpha(200),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  SizedBox(width: 5),
                                  Center(
                                    child: Text(
                                      'unselect',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
