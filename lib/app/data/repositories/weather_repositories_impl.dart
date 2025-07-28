import 'package:weather_app_assignment4/app/data/datasources/location_data_source.dart';
import 'package:weather_app_assignment4/app/data/datasources/weather_remote_data_source.dart.dart';
import 'package:weather_app_assignment4/app/domain/repositories/weather_repositories.dart';

import '../../domain/entities/weather.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final LocationDataSource locationDataSource;

  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.locationDataSource,
  });

  @override
  Future<Weather> getWeatherByCurrentLocation() async {
    final position = await locationDataSource.getCurrentLocation();
    final weather = await weatherRemoteDataSource.getWeather(
      position.latitude,
      position.longitude,
    );
    return weather;
  }
}
