import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Center(
        child: weatherProvider.isLoading
            ? const CircularProgressIndicator()
            : weatherProvider.weatherData == null
                ? ElevatedButton(
                    onPressed: () => weatherProvider.loadWeather(),
                    child: const Text("Get Weather"),
                  )
                : WeatherInfo(weatherData: weatherProvider.weatherData!),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherInfo({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${weatherData['name']}, ${weatherData['sys']['country']}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          "${weatherData['main']['temp']}°C",
          style: const TextStyle(fontSize: 48),
        ),
        Text(
          weatherData['weather'][0]['description'].toUpperCase(),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
