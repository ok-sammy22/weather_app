import 'package:weather_app_assignment4/app/domain/entities/forecast.dart';
import 'package:weather_app_assignment4/app/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.description,
    required super.icon,
    required super.forecast,
  });

  factory WeatherModel.fromJson(
    Map<String, dynamic> json,
    List<Forecast> forecast,
  ) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      forecast: forecast,
    );
  }
}
