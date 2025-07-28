import 'package:weather_app_assignment4/app/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherByCurrentLocation();
}
