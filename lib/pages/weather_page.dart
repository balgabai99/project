import 'package:flutter/material.dart';
import 'package:lesson/services/weather_service.dart';
import 'package:lesson/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _WeatherService = WeatherService('eafe861f27ae86974618500314527c8e');
  Weather? _weather;

   @override
  void initState() {
    super.initState();
    print('init');
    _fetchWeather();
  }

  _fetchWeather() async {
    print('fetch');
    String cityName = await _WeatherService.getCurrentCity();
    print('city: $cityName');
    try {
      print('try');
      final weather = await _WeatherService.getWeather(cityName);
      print('weather: $weather');
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'dust':
      case 'haze':
      case 'mist':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'asserts/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'loading city'),

            // animation

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}*C')
          ],
        ),
      ),
    );
  }
}
