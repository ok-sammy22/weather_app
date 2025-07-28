import 'package:weather_app_assignment4/app/domain/entities/forecast.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final List<Forecast> forecast;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.forecast,
  });
}
