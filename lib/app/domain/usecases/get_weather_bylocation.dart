import 'package:dartz/dartz.dart';
import 'package:weather_app_assignment4/app/domain/repositories/weather_repositories.dart';
import '../entities/weather.dart';

class GetWeatherByLocation {
  final WeatherRepository repository;

  GetWeatherByLocation(this.repository);

  Future<Either<String, Weather>> call() async {
    try {
      final weather = await repository.getWeatherByCurrentLocation();
      return Right(weather);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
