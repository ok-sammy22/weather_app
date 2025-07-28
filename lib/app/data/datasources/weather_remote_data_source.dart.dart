import 'package:dio/dio.dart';
import 'package:weather_app_assignment4/app/core/constants/api_constants.dart';
import 'package:weather_app_assignment4/app/data/model/model.dart';
import 'package:weather_app_assignment4/app/domain/entities/forecast.dart';

class WeatherRemoteDataSource {
  static const _apiKey = ApiConstants.apiKey;
  static const _baseUrl = ApiConstants.baseUrl;

  final Dio dio;

  WeatherRemoteDataSource({Dio? dio})
    : dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  Future<WeatherModel> getWeather(double lat, double lon) async {
    try {
      final weatherRes = await dio.get(
        '/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      if (weatherRes.statusCode != 200) {
        throw Exception('Error fetching weather');
      }

      final forecastRes = await dio.get(
        '/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      if (forecastRes.statusCode != 200) {
        throw Exception('Error fetching forecast');
      }

      final forecastList = (forecastRes.data['list'] as List)
          .where((e) => e['dt_txt'].toString().contains('12:00:00'))
          .map(
            (e) => Forecast(
              date: DateTime.parse(e['dt_txt']),
              temperature: (e['main']['temp'] as num).toDouble(),
              icon: e['weather'][0]['icon'],
            ),
          )
          .toList();

      return WeatherModel.fromJson(weatherRes.data, forecastList);
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
