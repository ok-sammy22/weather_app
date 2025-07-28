import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_assignment4/app/data/datasources/weather_remote_data_source.dart.dart';
import 'package:weather_app_assignment4/app/data/repositories/weather_repositories_impl.dart';
import 'package:weather_app_assignment4/app/domain/usecases/get_weather_bylocation.dart';
import '../../data/datasources/location_data_source.dart';
import '../../domain/entities/weather.dart';

final weatherProvider = FutureProvider<Weather>((ref) async {
  final repository = WeatherRepositoryImpl(
    weatherRemoteDataSource: WeatherRemoteDataSource(),
    locationDataSource: LocationDataSource(),
  );

  final usecase = GetWeatherByLocation(repository);
  final result = await usecase();

  return result.fold(
    (failure) => throw Exception(failure),
    (weather) => weather,
  );
});
