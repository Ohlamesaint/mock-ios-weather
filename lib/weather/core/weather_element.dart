enum WeatherElementEnum {
  wx('Wx', '天氣現象'),
  pop('PoP', '降雨機率'),
  minT('MinT', '最低溫度'),
  maxT('MaxT', '最高溫度'),
  ci('CI', '舒適度指數');

  final String eng;
  final String cht;

  const WeatherElementEnum(this.eng, this.cht);

  factory WeatherElementEnum.fromEng(String eng) {
    switch (eng) {
      case 'Wx':
        return wx;
      case 'PoP':
        return pop;
      case 'MinT':
        return minT;
      case 'MaxT':
        return maxT;
      case 'CI':
        return ci;
      default:
        throw ArgumentError('Unknown weather element: $eng');
    }
  }
}
