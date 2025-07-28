import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/weather_provider.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(weatherProvider);
          await ref.read(weatherProvider.future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: weatherAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (weather) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Text(weather.cityName, style: TextStyle(fontSize: 34)),
                    SizedBox(height: 10),
                    Text(
                      '${weather.temperature} °C',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(weather.description, style: TextStyle(fontSize: 17)),
                    Image.network(
                      'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
                    ),
                    const SizedBox(height: 20),
                    const Text('Forecast'),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weather.forecast.length,
                        itemBuilder: (_, i) {
                          final f = weather.forecast[i];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(DateFormat.E().format(f.date)),
                                  Image.network(
                                    'https://openweathermap.org/img/wn/${f.icon}.png',
                                  ),
                                  Text('${f.temperature}°C'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
