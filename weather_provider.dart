import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;

  Map<String, dynamic>? get weatherData => _weatherData;
  bool get isLoading => _isLoading;

  Future<void> loadWeather() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final location = await _locationService.getCurrentLocation();
      _weatherData = await _weatherService.fetchWeather(location.latitude, location.longitude);
    } catch (e) {
      print("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
