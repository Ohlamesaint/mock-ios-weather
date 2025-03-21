class WeatherElementValue {
  final String? name;
  final String? value;
  final String? unit;

  WeatherElementValue({
    required this.name,
    required this.value,
    required this.unit,
  });

  @override
  String toString() {
    return 'WeatherElementValue{name: $name, value: $value, unit: $unit}';
  }
}
